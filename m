Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279482AbRJXHjA>; Wed, 24 Oct 2001 03:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279483AbRJXHiv>; Wed, 24 Oct 2001 03:38:51 -0400
Received: from [62.14.144.124] ([62.14.144.124]:29956 "EHLO ragnar-hojland.com")
	by vger.kernel.org with ESMTP id <S279457AbRJXHik>;
	Wed, 24 Oct 2001 03:38:40 -0400
Date: Wed, 24 Oct 2001 01:45:12 +0200
From: Ragnar Hojland Espinosa <ragnar@ragnar-hojland.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: drevil@warpcore.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
Message-ID: <20011024014512.A7356@ragnar-hojland.com>
In-Reply-To: <20011022211622.B20411@virtucon.warpcore.org> <20011022172742.B445@virtucon.warpcore.org> <E15vnuN-0003jW-00@the-village.bc.nu> <20011022203159.A20411@virtucon.warpcore.org> <20011022214324.A18888@alcove.wittsend.com> <20011022211622.B20411@virtucon.warpcore.org> <17998.1003830655@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <17998.1003830655@redhat.com>; from dwmw2@infradead.org on Tue, Oct 23, 2001 at 10:50:55AM +0100
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2001 at 10:50:55AM +0100, David Woodhouse wrote:
> 
> drevil@warpcore.org said:
> >  What I am advocating is a little bit more sanity. The OS should not
> > break compatability with existing drivers so often for a 'stable'
> > release.
> 
> Name a driver in the 2.4.13-pre6 tree which doesn't compile and work with 
> the 2.4.13-pre6 kernel. 

Mitsumi (non-IDE CDROMs), broke at the 2.3.41-pre3 and 2.3.41-pre4
transition, and IIRC was still broken at 2.4.0 .. haven't got the drive here
so I can't test.

-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."
