Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUKETlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUKETlb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbUKETlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:41:22 -0500
Received: from [61.48.52.143] ([61.48.52.143]:34796 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261190AbUKETkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:40:16 -0500
Date: Fri, 5 Nov 2004 10:31:50 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200411051831.iA5IVo928353@adam.yggdrasil.com>
To: vonbrand@inf.utfsm.cl
Subject: Re: Possible GPL infringement in Broadcom-based routers
Cc: davids@webmaster.com, jp@enix.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst H. von Brand wrote:
>"Adam J. Richter" <adam@yggdrasil.com> said:

>[...]

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

>This is nonsense: If so, I'd be commiting a crime each time I fire up emacs
>on Solaris (linking (GPLed) emacs to (propietary) libc in RAM). [Yes, just
>an example; haven't done so for the best part of 5 years now...]

	It is based precisely on the idea that that is enforceable
that the FSF created an LGPL distinct from the GPL and also why it makes
a special exception for your type of use toward the end of section 3:

| However, as a
| special exception, the source code distributed need not include
| anything that is normally distributed (in either source or binary
| form) with the major components (compiler, kernel, and so on) of the
| operating system on which the executable runs, unless that component
| itself accompanies the executable.

>Besides, Linus has _explicitly_ said that binary (closed source) modules
>are OK (under certain conditions). And AFAIU there was legitimate
>discussion wether this particular excemption was required at al.

	I've seen messages that say quite the opposite.  Besides,
Linus is not the only copyright holder.  It only takes one copyright
for someone to be infringing.

	Again, I'm not a lawyer, so please don't take this as legal
advice.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
