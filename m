Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318061AbSIJU0q>; Tue, 10 Sep 2002 16:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSIJU0q>; Tue, 10 Sep 2002 16:26:46 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:22034 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S318061AbSIJU0p>; Tue, 10 Sep 2002 16:26:45 -0400
Date: Tue, 10 Sep 2002 22:31:22 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Joe Kellner <jdk@kingsmeadefarm.com>
Cc: John Alvord <jalvo@mbay.net>, linux-kernel@vger.kernel.org
Subject: Re: XFS?
Message-ID: <20020910203122.GU26075@louise.pinerecords.com>
References: <p73wupuq34l.fsf@oldwotan.suse.de> <20020909193820.GA2007@lnuxlab.ath.cx.suse.lists.linux.kernel> <Pine.LNX.4.44.0209091457590.3793-100000@hawkeye.luckynet.adm.suse.lists.linux.kernel> <p73wupuq34l.fsf@oldwotan.suse.de> <20020909162050.B4781@q.mn.rr.com> <5.1.0.14.2.20020910190828.00b27258@pop.gmx.net> <20020910142347.A5000@q.mn.rr.com> <92ksnuc403ubdr07dqvnor1mf9lr18srij@4ax.com> <1031689072.3d7e5370a83d2@webmail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031689072.3d7e5370a83d2@webmail>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 14 days, 8:35
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So does Redhat/Suse/??? ship XFS yet?
> 
> Mandrake has had XFS support in the default boot kernel since 8.0. AFAIK, Suse
> and  Slackware also have XFS capable kernels now too.

Slackware lets you use a special install kernel that has XFS [1] compiled in
and that the installer can take advantage of.  However, you have to provide
your own XFS vmlinuz for actually booting into the new system, as Slackware
rightly continues to use bare Marcelo(tm) kernels.

[1] and JFS, too.

T.
