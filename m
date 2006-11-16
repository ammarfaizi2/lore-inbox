Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424059AbWKPN47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424059AbWKPN47 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 08:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424060AbWKPN47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 08:56:59 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:30608 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1424059AbWKPN46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 08:56:58 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jody Belka <lists-lkml@pimb.org>
Subject: Re: [Suspend-devel] problem after s2ram restore with password-protected hdd
Date: Thu, 16 Nov 2006 14:53:56 +0100
User-Agent: KMail/1.9.1
Cc: suspend-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
References: <20061116135210.GR2808@pimb.org>
In-Reply-To: <20061116135210.GR2808@pimb.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611161453.56789.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 16 November 2006 14:52, Jody Belka wrote:
> [Please cc me on any reply, as i'm not subscribed]
> 
> I tried to use s2ram today on my Dell Inspiron 6000, but i'm having problems
> after wake-up when I have the hard drives internal password enabled (the
> normal state for this machine). If i turn the password off, everything works
> fine. I note that the password screen doesn't appear during wake-up, although
> the bios help text implies that it should do.

Well, this is a long-standing issue that hasn't been resolved yet.  There is
a patch available from http://bugzilla.kernel.org/show_bug.cgi?id=6840
but it is known to have problems.

> Well, works fine as long as I follow the advice at en.opensuse.org/S2ram
> and don't include vga=795 on the command-line, as I have an ATI Radeon
> graphics chipset. annoying, although I am in X usually anyway. Any news on
> that front?

I don't know, sorry.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
