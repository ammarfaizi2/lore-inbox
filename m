Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292150AbSBOV1L>; Fri, 15 Feb 2002 16:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292145AbSBOV1H>; Fri, 15 Feb 2002 16:27:07 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:18194
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S292149AbSBOV0n>; Fri, 15 Feb 2002 16:26:43 -0500
Date: Fri, 15 Feb 2002 15:59:46 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@suse.de>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020215155946.B14083@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215213833.J27880@suse.de> <E16bq0L-0004Ky-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16bq0L-0004Ky-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Feb 15, 2002 at 09:34:52PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> >  Sure CML2 fixes some bits that are not easily fixed in CML1,
> >  but I wonder sometimes how much of it is/was fixable.
> 
> Pretty much all of it. I wrote a proof of concept parser that can deduce
> the set of rules that must be enforced and what must be changed when you
> hit an option

Alan.  It didn't work.  It couldn't have -- among other things, the old
language can't tell visibility from implication.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
