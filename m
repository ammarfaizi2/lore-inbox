Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288677AbSBDHmj>; Mon, 4 Feb 2002 02:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288686AbSBDHm3>; Mon, 4 Feb 2002 02:42:29 -0500
Received: from coruscant.franken.de ([193.174.159.226]:16845 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S288677AbSBDHmU>; Mon, 4 Feb 2002 02:42:20 -0500
Date: Mon, 4 Feb 2002 08:38:31 +0100
From: Harald Welte <laforge@gnumonks.org>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.18-pre7 Fixed typo that made compiling impossible in /net/ipv4/netfilter/ipfwadm_core.c
Message-ID: <20020204083831.G26676@sunbeam.de.gnumonks.org>
In-Reply-To: <Pine.LNX.4.30.0202040155370.1740-200000@rtlab.med.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.30.0202040155370.1740-200000@rtlab.med.cornell.edu>; from calin@ajvar.org on Mon, Feb 04, 2002 at 02:04:58AM -0500
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Pungenday, the 28th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 02:04:58AM -0500, Calin A. Culianu wrote:
> 
> /net/ipv4/netfilter/ipfwadm_core.c has a typo.  The MOD_*_USE_COUNT macros
> are being used incorrectly.  Compiling was impossible as a result.
> 
> I fixed the typos.  It's trivial, but I figured I'd submit this just to
> make it easier for marcello to fix this...?  (this may have been submitted
> by someone else already.. but my quick scan of the mailing list didn't
> reveal anyone having patched this).

It has already been submitted, but thanks anyway :)

> -Calin

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
