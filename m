Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310995AbSCHSx2>; Fri, 8 Mar 2002 13:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310950AbSCHSxS>; Fri, 8 Mar 2002 13:53:18 -0500
Received: from pc-62-31-78-67-ed.blueyonder.co.uk ([62.31.78.67]:15507 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S310968AbSCHSxN>;
	Fri, 8 Mar 2002 13:53:13 -0500
Date: Fri, 8 Mar 2002 18:53:24 +0000
From: rob@mur.org.uk
To: linux-kernel@vger.kernel.org
Subject: Re: strange hang with promise ide and 2.4.18
Message-ID: <20020308185324.GF1043@mur.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020302134523.GA1022@mur.org.uk> <20020303173341.GO28780@lan.berghof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020303173341.GO28780@lan.berghof.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2002 at 06:33:41PM +0100, Wolfram Schlich wrote:
> Have you tried Andre Hedricks IDE-patch from
> http://www.kernel.org/pub/linux/kernel/people/hedrick/ide-2.4.18/ ?

Ok, I've tried it now, no difference. I can use 1 card but not 2. I
can't test the 3 card case because I gave the other one away. 

> 
> You could also try to enable CONFIG_PDC202XX_BURST, but I'm not
> sure.

I already had it enabled. Would disabling it make any difference? I
don't have much time to debug this problem.

I want to get an ata133 controller. Can anyone recommend one?
Stability is the most important criteria. 
> -- 
> Mit freundlichen Gruessen / Yours sincerely
> Wolfram Schlich; Berghof, D-56626 Andernach-Kell; +49-(0)2636-941194;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Rob Murray
