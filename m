Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270509AbTGSHZe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 03:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270510AbTGSHZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 03:25:34 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:22799 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S270509AbTGSHZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 03:25:33 -0400
Date: Sat, 19 Jul 2003 09:40:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Michael Still <mikal@stillhq.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       steve@ggi-project.org
Subject: Re: [PATCH] docbook: Added support for generating man files
Message-ID: <20030719074026.GA8821@mars.ravnborg.org>
Mail-Followup-To: Michael Still <mikal@stillhq.com>,
	Andries Brouwer <aebr@win.tue.nl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	steve@ggi-project.org
References: <20030719091919.A3236@pclin040.win.tue.nl> <Pine.LNX.4.44.0307191721350.1829-100000@diskbox.stillhq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307191721350.1829-100000@diskbox.stillhq.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 05:25:32PM +1000, Michael Still wrote:
> 
> ...and hit this. Another option is that we could ship a tweaked version of 
> docbook2man with the kernel sources, and call that copy. That could then 
> turn docinfo's into comments -- this was what I was getting at with my 
> previous message.

No, we do want to start adding tailored programs as part of
the kernel source.

	Sam
