Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282978AbSBJW23>; Sun, 10 Feb 2002 17:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284305AbSBJW2U>; Sun, 10 Feb 2002 17:28:20 -0500
Received: from mallaury.noc.nerim.net ([62.4.17.82]:33037 "HELO
	mallaury.noc.nerim.net") by vger.kernel.org with SMTP
	id <S282978AbSBJW2D>; Sun, 10 Feb 2002 17:28:03 -0500
Date: Sun, 10 Feb 2002 23:28:00 +0100
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, neilb@cse.unsw.edu.au,
        andre@linux-ide.org, jmontpezat@nerim.net
Subject: Re: [RAID-soft,ATA,WD] problems with a RAID5 disc not detected
Message-ID: <20020210222800.GA21060@calixo.net>
In-Reply-To: <20020210205653.GA20212@calixo.net> <20020210222409.B11EC8974E@cx518206-b.irvn1.occa.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020210222409.B11EC8974E@cx518206-b.irvn1.occa.home.com>
User-Agent: Mutt/1.3.27i
X-Face: "99`N"mZV/:<T->OLp[>#d3R;u.!ivtwAEpIQDL8rD#;L3Wm)~^)Uv=#;S!LZf1y8oRY7J#JR\Lr{*4Cn*32C89ln>0~5~tm--}j%hvhj+vtW><xbwA=@G8M||zPV0-r`:6zhMqq+_OC_0W*-:Wxzm3%|A5EE}VFnIgRU=+,L-hGdM"j&l'_^zK+%MBOsdmi#e3(3fGg^SGM
From: Cyrille Chepelov <cyrille@chepelov.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sun, Feb 10, 2002, à 02:24:09PM -0800, Barry K. Nathan a écrit:

> Cyrille Chepelov wrote:
> > Blam! the BIOS refuses to detect the WD disc, unless it's the only disc on
> > its ribbon cable (even with a 80-wire cable). Fortunately, Linux doesn't
> > really care, and it was possible to make use of this bad boy.
> 
> Note that "Master" and "Single" are generally two different jumper
> settings on WD disks; you need to use the "Master" setting when there are
> two drives on the cable and the "Single" setting when there's only one...

yep. That I'm sure I've triple-checked (no dice).

	-- Cyrille

-- 
Grumpf.

