Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTJ3KIq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 05:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTJ3KIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 05:08:46 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:34769 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262323AbTJ3KIp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 05:08:45 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Question on SIGFPE
Date: Thu, 30 Oct 2003 15:37:18 +0530
Message-ID: <94F20261551DC141B6B559DC4910867217764D@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question on SIGFPE
Thread-Index: AcOezZokdlP6vfquScqtxjwpry99yQ==
From: "Sreeram Kumar Ravinoothala" <sreeram.ravinoothala@wipro.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Sreeram Kumar Ravinoothala" <sreeram.ravinoothala@wipro.com>
X-OriginalArrivalTime: 30 Oct 2003 10:07:19.0340 (UTC) FILETIME=[9A75C6C0:01C39ECD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I am trying to run a multi threaded application on kernel 2.4.5.
The application vanishes without leaving any trace (no core dump) when
there is a link up on the hardware I use. If I try to debug I see the
application being killed because of SIGFPE. Can anyone throw some light
on this please? Also please cc the answer to me as I am not a member of
the list.

Thanks and Regards
Sreeram

---Never doubt that a small group of thoughtful, committed people can
change the world. Indeed, it is the only thing that ever has. -- Copied
from a mail
 
