Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbUBYIg3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 03:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbUBYIg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 03:36:28 -0500
Received: from [203.200.76.15] ([203.200.76.15]:63496 "EHLO
	ho-kkj-msg1.in.niit.com") by vger.kernel.org with ESMTP
	id S262482AbUBYIg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 03:36:27 -0500
Message-ID: <4CD9B982506A4148BF3AD77B16585C990C9DAE5A@ho-kkj-msg1.in.niit.com>
From: Dinesh Ahuja <DineshA@niit.com>
To: linux-kernel@vger.kernel.org
Subject: Libraries required to work with NPTL.
Date: Wed, 25 Feb 2004 13:48:55 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everybody,

I have to use POSIX Message Queues (mq_open),Semaphores and Shared Memory in
Red Hat Linux 9.0 which is having Linux Kernel 2.4. 
I searched the net and looked out that I need to upgrade my Kernel [default
2.4.20 with Linux 9.0] to 2.6 to work with these as it supports NPTL and
compatible with POSIX1.b, whereas Linux 2.4 doesn't fully supports POSIX
standards.

Please guide me what other libraries and settings needs to be done in
Kernel2.6 to compile and execute my C code to work with NPTL which is
POSIX1.b Standards compliant.

Regards
Dinesh 

----------------------------------------------------------- NOTICE
------------------------------------------------------------  
This email and any files transmitted with it are confidential and are solely
for the use of the individual or entity to which it is addressed. Any use,
distribution, copying or disclosure by any other person is strictly
prohibited. If you receive this transmission in error, please notify the
sender by reply email and then destroy the message. Opinions, conclusions
and other information in this message that do not relate to official
business of NIIT shall be understood to be neither given nor endorsed by
NIIT. Any information contained in this email, when addressed to NIIT
Clients is subject to the terms and conditions in governing client contract.
