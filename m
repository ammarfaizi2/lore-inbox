Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135844AbREAOih>; Tue, 1 May 2001 10:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135813AbREAOia>; Tue, 1 May 2001 10:38:30 -0400
Received: from ns.suse.de ([213.95.15.193]:54546 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135520AbREAOiG>;
	Tue, 1 May 2001 10:38:06 -0400
Date: Tue, 1 May 2001 16:38:04 +0200
From: Hubert Mantel <mantel@suse.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Alpha compile problem solved by Andrea (pte_alloc)
Message-ID: <20010501163804.D14970@suse.de>
Mail-Followup-To: Hubert Mantel <mantel@suse.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010430014653.C923@athlon.random> <E14uGya-0008He-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <E14uGya-0008He-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Apr 30, 2001 at 05:56:41PM +0100
Organization: SuSE Labs, Nuernberg, Germany
X-Operating-System: SuSE Linux - Kernel 2.2.19
X-PGP-Key: 1024D/B0DFF780, 1024R/CB848DFD
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 30, Alan Cox wrote:

> > OTOH x86 is racy and there's no workaround available at the moment.
> 
> -ac fixes all known problems there 

Is there some place from where one can download all the patches in -ac 
kernels as separate patches, not just one monster patch (same way Andrea 
is doing)?

I assume you are maintaining them as separate patches anyway in order to 
be able to feed them to Linus.

> Alan
                                                                  -o)
    Hubert Mantel              Goodbye, dots...                   /\\
                                                                 _\_v
