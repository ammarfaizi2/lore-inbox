Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSEQUVU>; Fri, 17 May 2002 16:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316676AbSEQUVU>; Fri, 17 May 2002 16:21:20 -0400
Received: from mailhost2.teleline.es ([195.235.113.141]:26912 "EHLO
	tsmtp5.mail.isp") by vger.kernel.org with ESMTP id <S316675AbSEQUVT>;
	Fri, 17 May 2002 16:21:19 -0400
Date: Fri, 17 May 2002 22:25:02 +0200
From: Diego Calleja <DiegoCG@teleline.es>
To: Dave Jones <davej@suse.de>
Cc: Wayne.Brown@altec.com, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
Message-Id: <20020517222502.7a6ecfe7.DiegoCG@teleline.es>
In-Reply-To: <20020517220922.M4712@suse.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002 22:09:22 +0200
Dave Jones <davej@suse.de> escribió:

> Spot the pattern? Exponential growth. not only that, but for the most
> part, the build system is the same across all of these. If we continue
> growing at the current rate without doing something about the build
> process, we're all going to be needing 8-way Opterons with several
> GB of memory to get any work done.

Well. If a miracle doesn't happen, i'll have to start thinking how to buy a 8-way Opteron....
> 
> If kbuild2.5 is faster, and produces the same end result (or better
> still, more accurate builds), there's no valid reason to ignore it
> that I can see.
> 
>     Dave.
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
