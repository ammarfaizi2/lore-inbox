Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273854AbRI0UPe>; Thu, 27 Sep 2001 16:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273855AbRI0UPY>; Thu, 27 Sep 2001 16:15:24 -0400
Received: from AMontpellier-201-1-1-55.abo.wanadoo.fr ([193.252.31.55]:5892
	"EHLO awak") by vger.kernel.org with ESMTP id <S273854AbRI0UPG> convert rfc822-to-8bit;
	Thu, 27 Sep 2001 16:15:06 -0400
Subject: Re: 2.4.10 (SMP, highmem) solid freeze
From: Xavier Bestel <xavier.bestel@free.fr>
To: Jason Czerak <Jason-Czerak@Jasnik.net>
Cc: Igor Mozetic <igor.mozetic@uni-mb.si>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1001600478.822.18.camel@neworder>
In-Reply-To: <15282.60654.52083.446184@proizd.camtp.uni-mb.si> 
	<1001600478.822.18.camel@neworder>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.14.99+cvs.2001.09.27.08.00 (Preview Release)
Date: 27 Sep 2001 22:09:54 +0200
Message-Id: <1001621400.18193.7.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Me Too" - dual pIII, not much mem used, was -ac15 without rik's patch,
found dead this morning.

le jeu 27-09-2001 at 16:21 Jason Czerak a écrit :
> On Thu, 2001-09-27 at 09:10, Igor Mozetic wrote:
> 
> Yeah, same thing happened here after about 7 or 8 hours of uptime.
> 
> Dual PIII-750. 1 gig ram. supermicro P6DGE. 128 meg swap partition (just
> in case). Adaptic 2490U2W
> 
> I'm dropping back to 2.4.9-ac11. that one seems to fix the high memory
> bug and was stable.
> 
> Also the 2.4.10 kernel seems to slow down after a while of uptime to.
> System seems sluggish. But that could be just Gnome 1.4 stuff.
> 
> 
> > After two days of uptime under load 2-3 (no swapping, not much I/O),
> > the box froze completely. Only hard reboot brought it back.
> > Nothing in logs, sorry ...
> > Hardware seems OK, other machines (UP, no highmem) run fine so far.
> > 
> > Hardware:
> > dual Xeon 550Mhz, C440GX+, 2GB RAM, 1GB swap, SCSI AIC-7896/7



