Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265797AbUFDOMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265797AbUFDOMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 10:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265791AbUFDOLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 10:11:31 -0400
Received: from gprs214-121.eurotel.cz ([160.218.214.121]:19585 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265787AbUFDOL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 10:11:26 -0400
Date: Fri, 4 Jun 2004 16:11:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040604141115.GE11950@elf.ucw.cz>
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de> <20040530111847.GA1377@ucw.cz> <xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>     >> In a nutshell, I hate to be restricted by YOUR own imaginations
>     >> of how people should hack the system.
> 
>     Vojtech> You're not. You're free to hack the kernel drivers. 
> 
> Not everyone using  Linux is patient enough to  explore the Wonderland
> of kernel hacking.  Many immigrants from 2.4 are highly disappointed
> by the new but incompatible mouse/keyboard behaviours.  Some of them
> returned to their 2.4 homeland because of this.

How can you propose moving keyboard handling to userland in one thread
and complain about 2.4-vs-2.6 incompatibility of inputs in another?!

2.4-vs-2.6 broke few strange keyboards. What you are proposing would
break everyone who has a keyboard.

								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
