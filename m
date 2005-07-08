Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262937AbVGHW26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbVGHW26 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbVGHW06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:26:58 -0400
Received: from [203.171.93.254] ([203.171.93.254]:26831 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262925AbVGHWZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:25:48 -0400
Subject: Re: [0/48] Suspend2 2.1.9.8 for 2.6.12
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Stefan Seyfried <seife@suse.de>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42CE8005.8020108@suse.de>
References: <11206164393426@foobar.com> <20050706082230.GF1412@elf.ucw.cz>
	 <20050706082230.GF1412@elf.ucw.cz> <1120696047.4860.525.camel@localhost>
	 <E1DqV7G-0004PX-00@chiark.greenend.org.uk>
	 <E1DqV7G-0004PX-00@chiark.greenend.org.uk>
	 <1120738525.4860.1433.camel@localhost>
	 <E1DqVp3-00064l-00@chiark.greenend.org.uk>  <42CE8005.8020108@suse.de>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120861635.7716.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 09 Jul 2005 08:27:15 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-07-08 at 23:30, Stefan Seyfried wrote:
> Matthew Garrett wrote:
> 
> > Right, so you support the resume from disk trigger in sysfs and the
> > /proc/acpi/sleep interface? If suspend2 is a complete dropin replacement
> > then I'm much happier with the idea of dropping swsusp, but I don't want
> > to have to tie suspend/resume scripts to kernel versions.
> 
> JFTR: i second this. There is already enough hackery involved if one
> wants to provide a smooth user experience ;-)

Consider it promised, and feel free to poke me if I forget! (That said,
I won't now!).

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

