Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbUBYI4P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 03:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbUBYI4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 03:56:15 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:41669 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S262491AbUBYI4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 03:56:08 -0500
To: Dinesh Ahuja <DineshA@niit.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Libraries required to work with NPTL.
References: <4CD9B982506A4148BF3AD77B16585C990C9DAE5A@ho-kkj-msg1.in.niit.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 25 Feb 2004 03:56:02 -0500
In-Reply-To: <4CD9B982506A4148BF3AD77B16585C990C9DAE5A@ho-kkj-msg1.in.niit.com>
Message-ID: <yq0r7wjo7vh.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dinesh" == Dinesh Ahuja <DineshA@niit.com> writes:

Dinesh> Hi Everybody, I have to use POSIX Message Queues
Dinesh> (mq_open),Semaphores and Shared Memory in Red Hat Linux 9.0
Dinesh> which is having Linux Kernel 2.4.  I searched the net and
Dinesh> looked out that I need to upgrade my Kernel [default 2.4.20
Dinesh> with Linux 9.0] to 2.6 to work with these as it supports NPTL
Dinesh> and compatible with POSIX1.b, whereas Linux 2.4 doesn't fully
Dinesh> supports POSIX standards.

Dinesh> Please guide me what other libraries and settings needs to be
Dinesh> done in Kernel2.6 to compile and execute my C code to work
Dinesh> with NPTL which is POSIX1.b Standards compliant.

Dear Dinesh,

The Red Hat 9.x kernels actually come with NPTL support builtin, as
such it shouldn't be necessary for you to switch to a 2.6 kernel.

However! Due to the obnoxious nature of you employer's email setup,
see below, I am providing you the above information under the contract
that you make sure to never post to linux-kernel again including the
below brain dead disclaimer and that you make sure to have your IT
department stop sending out such disclaimers. Disclaimers like these
are pointless and do not apply anyway as well as being obnoxious and
violates the spirit of public Internet email.

Using the above provided information for any NIIT business constitutes
acceptance of this contract between NIIT and the Linux community.

If you want to ask further technical questions, you are encouraged to
do so, but keep in mind that it must comply with this contract.

Best regards,
Jes

Dinesh> -----------------------------------------------------------
Dinesh> NOTICE
Dinesh> ------------------------------------------------------------
Dinesh> This email and any files transmitted with it are confidential
Dinesh> and are solely for the use of the individual or entity to
Dinesh> which it is addressed. Any use, distribution, copying or
Dinesh> disclosure by any other person is strictly prohibited. If you
Dinesh> receive this transmission in error, please notify the sender
Dinesh> by reply email and then destroy the message. Opinions,
Dinesh> conclusions and other information in this message that do not
Dinesh> relate to official business of NIIT shall be understood to be
Dinesh> neither given nor endorsed by NIIT. Any information contained
Dinesh> in this email, when addressed to NIIT Clients is subject to
Dinesh> the terms and conditions in governing client contract.
