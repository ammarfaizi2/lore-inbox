Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265002AbUHHCog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbUHHCog (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 22:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265022AbUHHCog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 22:44:36 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:197 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S265002AbUHHCof
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 22:44:35 -0400
Date: Sat, 7 Aug 2004 22:44:34 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: Juergen Pabel <jpabel@akkaya.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Masking kernel commandline parameters (2.6.7)
In-Reply-To: <200408080413.29905.jpabel@akkaya.de>
Message-ID: <Pine.LNX.4.58.0408072238570.22657@vivaldi.madbase.net>
References: <200408080413.29905.jpabel@akkaya.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 8 Aug 2004, Juergen Pabel wrote:
> my patch allows for kernel commandline parameters (ie: from
> bootloader) to be masked in order to prevent later retrieval

<snip>

> In other news: I am thinking of setting up a special
> kernel+initrd/initramfs project that will ask the user "nicely" to
> authenticate

That would make that ugly kernel patch pointless, wouldn't it? Then
why bother with it?

Eric
