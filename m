Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315456AbSGIPWO>; Tue, 9 Jul 2002 11:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSGIPWN>; Tue, 9 Jul 2002 11:22:13 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:48300 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S315456AbSGIPWN>;
	Tue, 9 Jul 2002 11:22:13 -0400
Date: Tue, 9 Jul 2002 17:24:49 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] using 2.5.25 with IDE
Message-ID: <20020709172449.A10605@ucw.cz>
References: <Pine.SOL.4.30.0207091613350.16892-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.4.30.0207091613350.16892-100000@mion.elka.pw.edu.pl>; from B.Zolnierkiewicz@elka.pw.edu.pl on Tue, Jul 09, 2002 at 04:17:39PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 04:17:39PM +0200, Bartlomiej Zolnierkiewicz wrote:

> Contrary to the popular belief 2.5.25 has only Martin's IDE-93
> and has broken locking...
> 
> If you want to run IDE on 2.5.25 get and apply:
> 
> IDE-94 by Martin
> IDE-95/96/97/98-pre by me
> 
> from:
> http://home.elka.pw.edu.pl/~bzolnier/ata/

Just for convenience, now that the 2.4 IDE backport has a BK tree, I've
put the above patches into BK, too, so anyone can pull them from:

http://linux-ide.bkbits.net:8080/linux-ide

I'll try to keep it up to date with latest 2.5 (hopefully working) IDE.

-- 
Vojtech Pavlik
SuSE Labs
