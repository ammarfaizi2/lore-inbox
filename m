Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271278AbRIVOiV>; Sat, 22 Sep 2001 10:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271329AbRIVOiM>; Sat, 22 Sep 2001 10:38:12 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:34309 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271278AbRIVOhw>;
	Sat, 22 Sep 2001 10:37:52 -0400
Date: Sat, 22 Sep 2001 11:38:15 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: linux-kernel@vger.kernel.org
Subject: Re: Whats in the wings for 2.5 (when it opens)
Message-ID: <20010922113815.B25545@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010918001826.7D118A0E5@oscar.casa.dyndns.org> <20010918214904.B29648@vdpas.hobby.nl> <20010921155806.B8188@mueller.datastacks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010921155806.B8188@mueller.datastacks.com>; from crutcher@datastacks.com on Fri, Sep 21, 2001 at 03:58:06PM -0400
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 21, 2001 at 03:58:06PM -0400, Crutcher Dunnavant escreveu:
> ++ 18/09/01 21:49 +0200 - toon@vdpas.hobby.nl:
> > On Mon, Sep 17, 2001 at 08:18:25PM -0400, Ed Tomlinson wrote:
> > > Seems like there is a lot of code "ready" for consideration in a 2.5 kernel.
> > > I can think of:
> > > premptable kernel option
> > > user mode kernel 
> > > jfs
> > > xfs (maybe)
> > ext3
> > > rc2
> > > reverse maping vm
> > > ide driver rewrite
> > > 32bit dma
> > > LTT (maybe)
> > > LVM update to 1.01
> > My opinion is that the LVM update to 1.01 should go into 2.4
> > as soon as possible.
> > > ELVM (maybe)
> > > module security stuff
> > > UP friendly SMP scheduler
> > > What else?

NetBEUI and more complete 802.2 net stacks, patches available at my work in
progress area at http://bazar.conectiva.com.br/~acme/patches/wip and at my
CVS repository at http://cvs.conectiva.com.br/kernel-acme.

- Arnaldo
