Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWIHRoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWIHRoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 13:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWIHRoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 13:44:19 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:54964 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1750897AbWIHRoT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 13:44:19 -0400
X-IronPort-AV: i="4.09,134,1157353200"; 
   d="scan'208"; a="340468011:sNHT29413204"
X-Mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: dprobe and kprobe support for ppc-32 bi arch.
Date: Fri, 8 Sep 2006 10:44:17 -0700
Message-ID: <F795765B112E7344AF36AA911279641502D19BA2@xmb-sjc-212.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: dprobe and kprobe support for ppc-32 bi arch.
Thread-Index: AcbTbmhofLlbdQYcSxO8Ae9ln4Gp/w==
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Sep 2006 17:44:18.0198 (UTC) FILETIME=[68A27B60:01C6D36E]
Authentication-Results: sj-dkim-1.cisco.com; header.From=bgholikh@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I understand dprobe and kprobe is integrated with linux 2.6 version. I
can not find the ppc 32 bit support. Am I missing something? 
Where can I get the patch for ppc 32-bit if it exist?
 
Thanks,
Bizhan
