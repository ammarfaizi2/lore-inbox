Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318008AbSHPCVw>; Thu, 15 Aug 2002 22:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318032AbSHPCVw>; Thu, 15 Aug 2002 22:21:52 -0400
Received: from [156.26.20.182] ([156.26.20.182]:42641 "EHLO surf.cadcamlab.org")
	by vger.kernel.org with ESMTP id <S318008AbSHPCVv>;
	Thu, 15 Aug 2002 22:21:51 -0400
Date: Thu, 15 Aug 2002 21:24:47 -0500
To: John Alvord <jalvo@mbay.net>
Cc: Greg Banks <gnb@alphalink.com.au>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
Message-ID: <20020816022447.GO17969@cadcamlab.org>
References: <Pine.LNX.4.44.0208141242280.8911-100000@serv> <3D5B0970.13CE831A@alphalink.com.au> <as7mlucq38obgsecg8kbh3vqjqiiic35bl@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as7mlucq38obgsecg8kbh3vqjqiiic35bl@4ax.com>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[John Alvord]
> I've been puzzling about this problem and the CML2 trainwreck.
> 
> Maybe we can used advanced tools to remove the many bugs and
> inconsistancies and then switch to a better config tool.

That's exactly what we're trying to do.  Greg has the advanced
consistency checking, and I've been trying to remove ambiguities and
warts in the current rule corpus, and simultaneously come up with some
extensions to the current language that will let us remove *more*
warts.  The extensions are designed to completely supplant certain
existing constructs which I consider ugly and difficult to parse.

To paraphrase Orwell: it was intended that when Newspeak had been
adopted once and for all and Oldspeak forgotten, a buggy parser should
be literally unimplementable, at least so far as implementation is
dependent on clear syntax and reasonable semantics.

Peter
