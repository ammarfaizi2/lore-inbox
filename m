Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbTKJFDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 00:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTKJFDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 00:03:43 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:55218 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262910AbTKJFDl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 00:03:41 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: problem in booting HP zx6000 with stock kernel 2.5.75
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Mon, 10 Nov 2003 10:32:02 +0530
Message-ID: <1E27FF611EBEFB4580387FCB5BEF00F3012909F2@blr-ec-msg04.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: problem in booting HP zx6000 with stock kernel 2.5.75
Thread-Index: AcOm85ipFvs8Oxv1QXGB53FfSWP6QwAVCjDg
From: "Ameya Mitragotri" <ameya.mitragotri@wipro.com>
To: "Deepak Kumar Gupta, Noida" <dkumar@noida.hcltech.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 10 Nov 2003 05:02:02.0554 (UTC) FILETIME=[C75949A0:01C3A747]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Deepak Kumar Gupta, Noida" <dkumar@noida.hcltech.com> wrote in message
news:<Q08Y.87p.3@gated-at.bofh.it>...
> 5. The kernel hangs after uncompressing the kernel successfully.
Nothing is
> working here, neither keyboard nor anything else.

Which SCSI driver is configured? I had a qla driver and i faced a
panic while booting 2.6.0-test5. This patch solved my problem

http://www.ussg.iu.edu/hypermail/linux/kernel/0309.2/0331.html

Hope that helps,
Ameya


