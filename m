Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbWHQO4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWHQO4D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWHQO4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:56:03 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:41452 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932110AbWHQO4A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:56:00 -0400
Message-ID: <44E482BD.8090405@aitel.hist.no>
Date: Thu, 17 Aug 2006 16:52:45 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Anonymous User <anonymouslinuxuser@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: GPL Violation?
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com>
In-Reply-To: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anonymous User wrote:
> I work for a company that will be developing an embedded Linux based
> consumer electronic device.
>
> I believe that new kernel modules will be written to support I/O
> peripherals and perhaps other things.  I don't know the details right
> now.  What I am trying to do is get an idea of what requirements there
> are to make the source code available under the GPL.
>
> I suspect the company will try to get away with releasing as little as
> possible.  I don't know much about the GPL or Linux kernel internals,
> but I want to encourage the company I work for to give back to the
> community.
Try to make them releasing more, pointing out that
holding onto almost anything concerning the kernel could
be dangerous for them.  They can keep the userspace
part secret if they have to, of course.
>
> I understand that modifications to GPL code must be released under the
> GPL.  So if they tweak a scheduler implementation, this must be
> released.  
Correct.
> What if a new driver is written to support a custom piece
> of hardware?  Yes, the driver was written to work with the Linux
> kernel, but it isn't based off any existing piece of code.
If the driver supports your custom piece of hardware, then you can
safely release the driver.  Your competitors don't have that
hardware, after all.  Releasing the driver can only increase sales,
because then customers know that the driver will be available
and fixable even if your company should stop supporting it sometime.
(Happens when companies die, and often when they release newer hardware.)
Smart customers think like this, and skip the closed stuff.

Remember, you don't make money from selling software.  You make it
from selling hardware.  Open free drivers will sell more hardware - simple!

> I'm posting anonymously because the company probably wouldn't want me
> discussing this at all  :(
Sad.

Helge Hafting
