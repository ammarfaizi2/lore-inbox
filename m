Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287969AbSABXWo>; Wed, 2 Jan 2002 18:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSABXWa>; Wed, 2 Jan 2002 18:22:30 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:9348
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287991AbSABXVU>; Wed, 2 Jan 2002 18:21:20 -0500
Date: Wed, 2 Jan 2002 18:07:54 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102180754.A21788@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
	Lionel Bouton <Lionel.Bouton@free.fr>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102174824.A21408@thyrsus.com> <E16LubO-0005xF-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16LubO-0005xF-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 02, 2002 at 11:15:17PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > (Telling me to rely on dmidecode already being installed SUID is not
> > a good answer either.  No prizes for figuring out why.)
> 
> Well you can't rely on the kernel having the modification either. 

If /proc/dmi were to go in soon, at least I *could* rely on it in 2.6.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Live free or die; death is not the worst of evils.
	-- General George Stark.
