Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288270AbSACRmn>; Thu, 3 Jan 2002 12:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288275AbSACRme>; Thu, 3 Jan 2002 12:42:34 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:62089
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288279AbSACRm1>; Thu, 3 Jan 2002 12:42:27 -0500
Date: Thu, 3 Jan 2002 12:27:59 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        David Woodhouse <dwmw2@infradead.org>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020103122759.A14081@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>, Rik van Riel <riel@conectiva.com.br>,
	David Woodhouse <dwmw2@infradead.org>,
	Lionel Bouton <Lionel.Bouton@free.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0201031452170.24031-100000@imladris.surriel.com> <Pine.LNX.4.33.0201031800480.7309-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201031800480.7309-100000@Appserv.suse.de>; from davej@suse.de on Thu, Jan 03, 2002 at 06:01:31PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de>:
> > > You have my intentions backwards. What I'd like to be able to do is
> > > suppress ISA_SLOTS when there are detectably *no* ISA cards.
> > So you want to make it impossible to compile kernels for
> > old machines on the new fast machine standing next to it ?
> 
> I assumed ESR proposed a 'configure for this box' button,
> not the default case.

Exactly.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The two pillars of `political correctness' are, 
  a) willful ignorance, and
  b) a steadfast refusal to face the truth
	-- George MacDonald Fraser
