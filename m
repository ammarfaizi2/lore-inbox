Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267188AbTA0Mgo>; Mon, 27 Jan 2003 07:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267190AbTA0Mgo>; Mon, 27 Jan 2003 07:36:44 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8452 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267188AbTA0Mgn>;
	Mon, 27 Jan 2003 07:36:43 -0500
Date: Mon, 27 Jan 2003 13:42:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please consider)
Message-ID: <20030127124241.GB650@elf.ucw.cz>
References: <20030124154935.GB20371@elf.ucw.cz> <20030124171415.34636.qmail@web80310.mail.yahoo.com> <20030124180255.GF1099@marowsky-bree.de> <b0sqag$mau$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0sqag$mau$1@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >All alternatives I have seen to UML (plex, vmware, UMLinux) suck IMHO.
> 
> It seems plausible to expect that it might be easier to verify security
> in plex86-based approaches than it is to verify security in UML.

As plex86 uses pretty obscure tricks (like PVI -- is it even
documented in official Intel docs?), I doubt it is going to be easier
to verify.
								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
