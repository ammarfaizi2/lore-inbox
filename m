Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284998AbRLUTNc>; Fri, 21 Dec 2001 14:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285013AbRLUTNX>; Fri, 21 Dec 2001 14:13:23 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:48006 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S284998AbRLUTNP>;
	Fri, 21 Dec 2001 14:13:15 -0500
Date: Fri, 21 Dec 2001 20:12:59 +0100
From: David Weinehall <tao@acc.umu.se>
To: David Garfield <garfield@irving.iisd.sra.com>
Cc: esr@thyrsus.com, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
Message-ID: <20011221201259.N5235@khan.acc.umu.se>
In-Reply-To: <20011220143247.A19377@thyrsus.com> <15394.29882.361540.200600@irving.iisd.sra.com> <20011220185226.A25080@thyrsus.com> <15395.33489.779730.767039@irving.iisd.sra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <15395.33489.779730.767039@irving.iisd.sra.com>; from garfield@irving.iisd.sra.com on Fri, Dec 21, 2001 at 01:43:29PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 01:43:29PM -0500, David Garfield wrote:
> Eric S. Raymond writes:
>  > David Garfield <garfield@irving.iisd.sra.com>:
>  > > Another option: maybe the choice of KB vs KiB vs KKB should be a
>  > > configuration choice.
>  > 
>  > You *must* be joking.
>  > 
>  > Please tell me you're joking.
> 
> No, I'm serious.  I will understand if CML2 does not support
> meta-configuration.  A configuration choice as I described above could
> be viewed as a minor facet of a language configuration choice.
> (Should kernel configuration be internationalized or at least
> internationalizable?)
> 
> Choice of kB vs KB vs KiB vs KKB could also be used in some places in
> the kernel.  For instance, /proc/meminfo currently shows "kB".

Whatever the choice ends up being, KB is always incorrect, unless you
intend to specify some strange formula where the number of bytes (B)
combined with the temperature in Kelvin (K) has anything to do with
things.



/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
