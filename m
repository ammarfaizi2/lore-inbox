Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTK1QY1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 11:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTK1QY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 11:24:27 -0500
Received: from law12-oe43.law12.hotmail.com ([64.4.18.15]:47119 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262601AbTK1QYK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 11:24:10 -0500
X-Originating-IP: [24.61.138.213]
X-Originating-Email: [iainbarker@hotmail.com]
Reply-To: "Iain Barker" <ibarker@member.fsf.org>
From: "Iain Barker" <ibarker@member.fsf.org>
To: <linux-kernel@vger.kernel.org>
Subject: RE: possible GPL violation by Sigma Designs
Date: Fri, 28 Nov 2003 11:23:52 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <Law12-OE43OFr3gIa7Z00005766@hotmail.com>
X-OriginalArrivalTime: 28 Nov 2003 16:24:09.0570 (UTC) FILETIME=[0D2FD420:01C3B5CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I purchased a Liteon LVD2001 DVD player which uses this Sigma EM8500 chipset
and firmware running Linux. I wanted to compile kernel support for other
devices in the PCMCIA slot of this DVD player but source code for their
modified kernel is not provided.

This GPL violation of the Linux kernel was previously raised on LKML in
September http://lkml.org/lkml/2003/9/8/68  but nothing seems to have
happened since then, so I tried contacting the manufacturer directly.

The Sigma firmware is a binary-only distribution by Liteon, which includes a
modified port of the Linux 2.4 kernel, specifically ARM uClinux with
busybox. There are also two binary loadable modules for the hardware device
drivers (GPL status for these is unknown), plus some proprietary non-GPL DVD
player applications of no concern here.

Liteon has not included the GPL license or the source code (or offer of
source) for the Sigma Linux binaries they are distributing, so I contacted
them by email requesting the source code to these GPL components.

Below is the email I received back refusing to issue the source code.

I have sent a followup email to Liteon noting that providing GPL source code
is not optional, I also said I would pass on this information for the Linux
authors response, hence this LKML posting.

As the majority of the GPL code is from Linux, if any copyright holder wants
to follow up please email me direct and I'll forward you the complete
summary. Note that I've made no attempt at reverse engineering, the origins
of this code are all quite obvious from the earlier LKML thread.

regards.
Iain Barker


ps. I already sent the summary to GPL violations at GNU/FSF in case they are
interested in taking it further, but as Linux primarily isn't FSF copyright
I don't think they will be able to - only the copyright owners (authors of
Linux) have the ability to enforce the kernel GPL.


-----Original Message-----
From: DCTW_Service@liteonit.com
Sent: Thursday, 27 November, 2003 06:54
To: Iain Barker
Subject: Re: Liteon LVD firmware(source code)



Dear Sir,

Sorry to tell you that we don't provide the source code to user.
Please be noticed and thanks for your kindly understanding!

BR!

AW






-----Original Message-----
From: Iain Barker

Sent: 2003/11/23 11:35 AM
To:   dctw_service@liteonit.com
cc:

Subject:  Liteon LVD firmware





Dear Sir,

On your website are distribution images containing updated code for LVD
firmware.  http://www.liteonit.com/DC/english/images/zip/2001-0229.zip

The firmware CD image contains binaries for Linux kernel and other GNU
Public License (GPL) software. I find no source code or offer of source code
provided with the Liteon binary firmware images.

For all GPL licensed code you are required to provide source code, or an
offer for source code, along with the binary.

Please inform me where I can obtain the source code for the GPL portions of
Liteon software. This is Legally required to be provided by you, for binary
distribution purposes of GPL such as this product.

Details of the copyright and license distribution terms are here:
http://www.linux.org/info/gnu.html

I have summarised the appropriate section below for your convenience.

thankyou in advance.

Iain Barker
Liteon LVD 2001 customer



"
You may copy and distribute the Program or a work based on it ... in object
code or executable form ... provided that you also do one of the following:

a) Accompany it with the complete corresponding machine-readable source
code...; or,
b) Accompany it with a written offer, valid for at least three years, to
give any third party, for a charge no more than your cost of physically
performing source distribution, a complete machine-readable copy of the
corresponding source code...; or,
c) Accompany it with the information you received as to the offer to
distribute corresponding source code. (This alternative is allowed only for
noncommercial distribution and only if you received the program in object
code or executable form with such an offer...)
"

