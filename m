Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263533AbUJ2Xhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263533AbUJ2Xhx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263683AbUJ2Xhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:37:50 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:39697 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S263533AbUJ2XeD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:34:03 -0400
X-Ironport-AV: i="3.86,111,1096866000"; 
   d="scan'208"; a="99940391:sNHT19511748"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Date: Fri, 29 Oct 2004 18:33:59 -0500
Message-ID: <4B0A1C17AA88F94289B0704CFABEF1ABC3460C@ausx2kmps304.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Thread-Index: AcS9/Fb9XwwPmP7rSh6OztBQ42HawQAEXY2wAABxFKA=
From: <Tim_T_Murphy@Dell.com>
To: <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Oct 2004 23:34:00.0983 (UTC) FILETIME=[C4DD2270:01C4BE0F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> maddr:	10		# note, this is for the UP kernel. for
SMP, maddr=201
> irqno:	ec40

duh, i got maddr and irqno backwards in my last post, sorry.
Tim
