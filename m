Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbQLSRpT>; Tue, 19 Dec 2000 12:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129535AbQLSRo7>; Tue, 19 Dec 2000 12:44:59 -0500
Received: from uucp.nl.uu.net ([193.79.237.146]:51885 "EHLO uucp.nl.uu.net")
	by vger.kernel.org with ESMTP id <S129429AbQLSRoz>;
	Tue, 19 Dec 2000 12:44:55 -0500
Date: Tue, 19 Dec 2000 18:05:33 +0100 (CET)
From: kees <kees@schoen.nl>
To: "John O'Donnell" <johnod@voicefx.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: old binary works not with 2.2.18
In-Reply-To: <3A3EB7F0.3050905@voicefx.com>
Message-ID: <Pine.LNX.4.21.0012191803250.6506-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Yep, *After* I build a new kernel I _always_ build a new iBCS module.

I have an old utility 'hd' (hexdump) from SCO3.2v4.2 that also needs iBCS
but has a slightly different format, *that* works under 2.2.18

Kees



On Mon, 18 Dec 2000, John O'Donnell wrote:

> kees wrote:
> 
> > Hi,
> > 
> > I have an old 4GL application (from SCO3.2v4) that is a neat database
> > tool. Under 2.2.17 with iBCS this works well:
> 
> I am just curious.  Did you re-compile the iBCS2 module after upgrading
> to 2.2.18 to did you force the module to load up...
> 
> With Slackware and kernel upgrades this is a regular procedure with me
> otherwise chaos ensues  :-)
> Johnny O
> 
> -- 
> <SomeLamer> what's the difference between chattr and chmod?
> <SomeGuru> SomeLamer: man chattr > 1; man chmod > 2; diff -u 1 2 | less
> 	-- Seen on #linux on irc
> === Never ask a geek why, just nod your head and slowly back away.===
> +==============================+====================================+
> | John O'Donnell (Sr. Systems Engineer, Net Admin, Webmaster, etc.) |
> | Voice FX Corporation (a subsidiary of Student Advantage)          |
> | One Plymouth Meeting         |     E-Mail: johnod@voicefx.com     |
> | Suite 610                    |           www.voicefx.com          |
> | Plymouth Meeting, PA 19462   |         www.campusdirect.com       |
> +==============================+====================================+
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
