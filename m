Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbTAJRcX>; Fri, 10 Jan 2003 12:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTAJRcW>; Fri, 10 Jan 2003 12:32:22 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:12304 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265854AbTAJRcV>;
	Fri, 10 Jan 2003 12:32:21 -0500
Date: Fri, 10 Jan 2003 18:40:58 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Rusty Russell <rusty@rustcorp.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Craig Wilkie <craig@homerjay.homelinux.org>
Subject: Re: [TRIVIAL] [PATCH 1 of 3] Fix errors making Docbook documentation
Message-ID: <20030110174058.GB1163@mars.ravnborg.org>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Craig Wilkie <craig@homerjay.homelinux.org>
References: <1041866409.17472.25.camel@irongate.swansea.linux.org.uk> <20030110073328.A11712C0DD@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030110073328.A11712C0DD@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > Grab the docbook for those files from 2.4 and also the changes to the
> > docbook generator

I have updated scripts/kernel-doc once from 2.4, I will check again
if there are new updates.
I saw good improvements in reporting when updating it last time,
people actually had a chance to locate were documentation was missing.

And I prefer a warning, to remind people that an update is needed.

	Sam
