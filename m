Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316788AbSGZEuJ>; Fri, 26 Jul 2002 00:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316789AbSGZEuJ>; Fri, 26 Jul 2002 00:50:09 -0400
Received: from [195.63.194.11] ([195.63.194.11]:56069 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316788AbSGZEuH>; Fri, 26 Jul 2002 00:50:07 -0400
Message-ID: <3D409874.3050104@evision.ag>
Date: Fri, 26 Jul 2002 02:31:48 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: vojtech@ucw.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: input: fix sleep support, kill bad ifdefs, cleanup comments
References: <20020725103713.GA522@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> It is possible to kill few #ifdefs from input.c, so I did that.
> 
> Comments far to the left hurt readability in my eyes (I believe
> input.c has *way* too much comments, too, but...).

Yes that's Vojtech in action. They don't just hurt my eyes. More 
importantly - they interferre with the usage of folding in some editors.
So please consider a style change. (And using FB if console is to narrow
for you. vga=0x318 always worked for me. No GNOME, no KDE, just X11 + 
MWM is a good terminal launcher as well - even if rebooting frequently.)

However: Please note that I greatly welcome that Vojtech
actually *does* good commenting in exceptionally *exemplary* 
comprehensive and adequate style!




