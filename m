Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUFQUWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUFQUWq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 16:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUFQUWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 16:22:46 -0400
Received: from sanosuke.troilus.org ([66.92.173.88]:5264 "EHLO
	sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S262418AbUFQUWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 16:22:44 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: hch@lst.de, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: more files with licenses that aren't GPL-compatible
From: mdpoole@troilus.org
References: <200406180629.i5I6Ttn04674@freya.yggdrasil.com>
	<87n032xk82.fsf@sanosuke.troilus.org> <20040617100930.A9108@adam>
Date: Thu, 17 Jun 2004 16:22:42 -0400
In-Reply-To: <20040617100930.A9108@adam> (Adam J. Richter's message of "Thu,
 17 Jun 2004 10:09:30 -0700")
Message-ID: <87isdqx7cd.fsf@sanosuke.troilus.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter writes:

> On Thu, Jun 17, 2004 at 11:44:29AM -0400, Michael Poole wrote:
>> The first "official" version of Linux that included USB serial code
>> that mentioned you (Adam Richter and/or Yggdrasil) was 2.4.  That same
>> version included the same binary firmware you complained about in
>> 2001, and the changelog in usbserial.c makes it clear that *at least*
>> the WhiteHEAT firmware was already present when you contributed your
>> code.
>> 
>> Would you explain why your claim of copyright infringement is not
>> estopped by the pre-existing condition of firmware being present?
>
> 	Why would it be, and what kind of stopping ("estoppel")
> are you referring to?
[snip]

>From what I can see, the USB serial drivers included firmware images
before you contributed to that code.  If you contributed changes with
reckless disregard to their presence (i.e. should have known they were
there and you did not say "I contribute this on the condition that the
maintainers work to remove binary firmware"), I believe that you
accepted their presence.

http://www.ipwatchdog.com/equitable_estoppel.html discusses equitable
estoppel vis-a-vis patent rights (which are treated similarly to
copyrights by many courts).  When you contributed your changes to the
USB maintainers, they -- and later redistributors -- inferred that you
would not allege copyright infringement by applying your changes to
the kernel that existed then.

The first binary firmware I found in the kernel was included in linux
2.0, released in June 1996.  There might be an earlier case.  You
might argue plausible ignorance of that particular driver, but you as
an individual have a harder claim to demonstrate.  See below.

> 	I know I have been complaining about the infringing drivers
> and asking that people stop infringing approximately since I became
> aware of the infringement.

You managed to contribute some significant creative (copyrightable)
change to the USB serial code without noticing that *a quarter* of the
files in that directory were headers that defined firmware?  I do not
know if a court would take such a claim seriously, but as a software
developer, I do not.

> 	Again, I'm not a lawyer, so please do not use my layman's
> opinions as legal advice.

I am aware of several reasons your writings are not legal advice.  As
another non-lawyer, though, I wanted to give you a chance to defend
your claims before I decide they are entirely meritless.

Michael
