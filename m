Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289806AbSBEUe6>; Tue, 5 Feb 2002 15:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289809AbSBEUes>; Tue, 5 Feb 2002 15:34:48 -0500
Received: from gre12-18.n.club-internet.fr ([195.36.211.18]:5124 "HELO
	lanzarote.fxk.org") by vger.kernel.org with SMTP id <S289806AbSBEUed>;
	Tue, 5 Feb 2002 15:34:33 -0500
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4.17 kills processes in shrink_cache
In-Reply-To: <lvelk23edc.fsf@fuerteventura.fxk.org>
	<3C5D41AB.2080207@wanadoo.fr>
X-Face: "(f3\<&&St}J$nr=ZjygGjeVd}5q~>[n~+5^>{c2#.1+jvCZxr1BNq#*C3p,2gRi^9e0osq
 A%OL;jNrgIf(S9[ala/vrL<4p=&HC(GV;`)v!}G8>U9s<6aJ(H19^[N-@UrmHqlyQ7A7@I8{u1/W+U
 pa+WWPU^@a;=qxw|_?|mwkSc7HI4`M4DTt|*BXPlX40uQ_ts$7$U9LN;gdd1a?=Ket6&Nfb=
From: "Francois-Xavier 'FiX' KOWALSKI" 
	<francois-xavier.kowalski@club-internet.fr>
Date: 05 Feb 2002 21:34:27 +0100
In-Reply-To: <3C5D41AB.2080207@wanadoo.fr>
Message-ID: <lvu1sv4qi4.fsf@fuerteventura.fxk.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet <pierre.rousselet@wanadoo.fr> writes:

> Francois-Xavier 'FiX' KOWALSKI wrote:
> > I encounter the following kernel error using stock kernel.org 2.4.17:
> > kernel BUG at vmscan.c:360!
> ..snip..
> > Looking on various linux-kernel ML archives, I found that the VM is
> > having some troubles, but no failure with the same backtrace as the
> > one I have, whereas I always have exactly the same one, at least on
> > the 2 lowest levels:
> 
> Many problems were reported with 2.4.17: kswapd/swapper, ext2
> corruption, devfs bug... Couldn't you upgrade to 2.4.18-pre7 ?

Thanks for the advice.  I saw that many bug-fixes are included within
18-pre7, but I was hoping to be able to stick on permanent
releases... :-(

FiX
-- 
François-Xavier 'FiX' KOWALSKI

