Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbUKET3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbUKET3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbUKET3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:29:07 -0500
Received: from [61.48.52.143] ([61.48.52.143]:39915 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261163AbUKET25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:28:57 -0500
Date: Fri, 5 Nov 2004 10:20:42 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200411051820.iA5IKgT28261@adam.yggdrasil.com>
To: mdpoole@troilus.org
Subject: Re: Possible GPL infringement in Broadcom-based routers
Cc: davids@webmaster.com, jp@enix.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Poole writes:
>Adam J. Richter writes:

>> 	I think you're missing the idea that that such drivers are
>> _contributory_ infringement to the direct infringement that occurs when
>> the user loads the module.  In other words, even for a driver that has
>> not a byte of code derived from the kernel, if all its uses involve it
>> being loaded into a GPL'ed kernel to form an infringing derivative
>> work in RAM by the user committing direct copyright infringement against
>> numerous GPL'ed kernel components, then it fails the test of having
>> a substantial non-infringing use, as established in the Betamax decision,
>> and distributing it is contributory infringement of those GPL'ed
>> components of the kernel.

>Combining GPLed works with GPL-incompatible works violates the GPL if
>you distribute the result; the GPL allows one to make that kind of
>combination for one's own use.  Go read the GPL more closely.

	There are US court cases that have established that copying
into RAM is copying for the purposes of copyright.  Also, I'd have
to say that loading a module into a kernel is modification.

	My understanding is that the FSF was able to get Next Computer
to release its Objective C modules for gcc, over just this sort of
"user does the link" issue.

	Also, as was pointed out by Bradley Kuhn at FSF's two
day GPL seminar at Standard Law School, where we picked apart
the GPL and LGPL for about twelve hours, the GPL is a grant
of permission.  People "plead the GPL to us" as Bradley put it.
If you want to argue that the GPL does not cover some action, I don't
think that's the same as saying that the GPL gave you permission to
do it.  You would still have to argue that that action is not
restrictable by copyright.  Fortunately, I don't think the argument
comes to that, because of what I said in the first two paragraphs,
but it's something you might want to think about before raising that
argument in the future.

	Again, I am not a lawyer, so please don't take this as legal
advice.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
