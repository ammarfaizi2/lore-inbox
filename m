Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSL2Wor>; Sun, 29 Dec 2002 17:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbSL2Wor>; Sun, 29 Dec 2002 17:44:47 -0500
Received: from maild.telia.com ([194.22.190.101]:63721 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S261448AbSL2Woq>;
	Sun, 29 Dec 2002 17:44:46 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
Date: Sun, 29 Dec 2002 23:53:05 +0100
From: Christian Axelsson <smiler@lanil.mine.nu>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: Re: PROBLEM: Plextor CD-RW hangs when reading via cdrdao/xine/mplayer and ide-scsi
Message-Id: <20021229235305.146221d5.smiler@lanil.mine.nu>
In-Reply-To: <1041201603.17115.47.camel@vertex.bastion.free-bsd.org>
References: <1041201603.17115.47.camel@vertex.bastion.free-bsd.org>
Organization: LANIL
X-Mailer: Sylpheed version 0.8.6claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Dec 2002 23:40:03 +0100
"Christian \"cycloon\" Gut" <cycloon@is-root.org> wrote:

<snip>
> Hi!
> I got some problems with my IDE Burner Plextor 2410TA. Bugreport
> following:
> 
> [1.]My IDE CD-RW drive hangs when reading a cd via cdrdao/xine/mplayer
> and ide-scsi.
> 
> [2.]My whole system is compiled with gcc 3.2 (using gentoo). When i try
> to read CDs(especially happens with VCDs) with cdrdao, xine, mplayer or
> even vcdimager the application suddenly hangs and the CD-Drive doesn't
> stop to run and run.
> The Problem is not Hardwaredependant, cause it works fine under Knoppix
> and Windows. I think it depends on gcc > 3 as it worked before and still
> works under Knoppix.
> 
</snip>

I have an identical drive, it runs great under gentoo aswell but all programs
are compiled with gcc 3.2, but I think it's not very compiler dependent.
I run the drive as an IDE-scsi device aswell.

-- 
Christan Axelsson
smiler@lanil.mine.nu
