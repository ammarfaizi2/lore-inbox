Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263134AbUFVM2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUFVM2T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 08:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUFVM2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 08:28:19 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:4108 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263134AbUFVM2N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 08:28:13 -0400
Date: Tue, 22 Jun 2004 14:28:13 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Matroxfb in 2.6 still doesn't work in 2.6.7
Message-ID: <20040622122813.GE28577@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040618211031.GA4048@irc.pl> <20040619190503.GB17053@vana.vc.cvut.cz> <20040619193053.GA3644@irc.pl> <20040619203954.GC17053@vana.vc.cvut.cz> <20040620160437.GA29046@irc.pl> <20040620170114.GA4683@vana.vc.cvut.cz> <20040620213743.GA6974@irc.pl> <20040621013136.GB4683@vana.vc.cvut.cz> <20040621181003.GB28577@irc.pl> <MPG.1b41a0f6b20282e39896d1@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MPG.1b41a0f6b20282e39896d1@news.gmane.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 02:51:24AM +0200, Giuseppe Bilotta wrote:
> Tomasz Torcz wrote:
> > On Mon, Jun 21, 2004 at 03:31:36AM +0200, Petr Vandrovec wrote:
> > > > > > > video=matroxfb:vesa:0x11A,right:48,hslen:112,left:248,hslen:112,lower:1,vslen:3,upper:48
> > > > > > > maybe with ',sync:3' if +hsync/+vsync are mandatory for your monitor.
> > > 
> > > 1280x1024-60 just selects some videomode fbdev subsystem thinks your monitor should use,
> > > while vesa:0x11A selects videomode I think you should use.
> > 
> >  Could fbdev be changed to select the same videomode as vesa: switch?
> 
> There is a vesafb-tng (the next generation) on Gentoo. 

 Well, we were talking about matroxfb, switched by video=matroxfb:vesa:xxx option.

-- 
Tomasz Torcz                 "God, root, what's the difference?" 
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."   

