Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUKESqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUKESqL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 13:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbUKESqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 13:46:11 -0500
Received: from [61.48.52.143] ([61.48.52.143]:45547 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261156AbUKESqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 13:46:09 -0500
Date: Sat, 6 Nov 2004 02:40:35 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200411061040.iA6AeZp03452@freya.yggdrasil.com>
To: davids@webmaster.com, jp@enix.org, linux-kernel@vger.kernel.org
Subject: RE: Possible GPL infringement in Broadcom-based routers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  == David Schwartz
>> == Jerome Petozzoni

>> Can Broadcom and the vendors "escape" the obligations of the GPL by
>> shipping those proprietary drivers as modules, or are they violating the
>> GPL plain and simple by removing the related source code (and showing
>> irrelevant code to show "proof of good will") ?
>
>        That is a contentious issue that has been debated on this group far too
>much. In the United States, at least, the answer comes down to the complex
>legal question of whether the module is a "derived work" of the Linux kernel
>and whether the kernel as shipped with those modules is a "mere
>aggregation".

	I am not a lawyer, so please do not use this as legal advice.

	I think you're missing the idea that that such drivers are
_contributory_ infringement to the direct infringement that occurs when
the user loads the module.  In other words, even for a driver that has
not a byte of code derived from the kernel, if all its uses involve it
being loaded into a GPL'ed kernel to form an infringing derivative
work in RAM by the user committing direct copyright infringement against
numerous GPL'ed kernel components, then it fails the test of having
a substantial non-infringing use, as established in the Betamax decision,
and distributing it is contributory infringement of those GPL'ed
components of the kernel.

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
