Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315937AbSENR4Y>; Tue, 14 May 2002 13:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315938AbSENR4X>; Tue, 14 May 2002 13:56:23 -0400
Received: from 213-97-251-19.uc.nombres.ttd.es ([213.97.251.19]:65408 "EHLO
	mortadelo") by vger.kernel.org with ESMTP id <S315937AbSENR4W>;
	Tue, 14 May 2002 13:56:22 -0400
Date: Tue, 14 May 2002 18:00:31 +0000
From: Ragnar <ragnar@ragnar-hojland.com>
To: Mike <mikeh@notnowlewis.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fam and libfam
Message-ID: <20020514180031.GA2051@ragnar-hojland.com>
In-Reply-To: <200205091421.13741.mikeh@notnowlewis.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 02:21:13PM +0100, Mike wrote:
> Hi all,
> 
> I was wondering if there were still patches about to add fam to the kernel, 
> instead of using libfam? Or have I missed a config option ;)

There is support in the kernel for getting back info "a la fam", but this is
done via signals.

-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  |  www.brainbench.com
   U     chaos and madness await thee at its end."
