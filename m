Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283049AbRK1OKU>; Wed, 28 Nov 2001 09:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283058AbRK1OKP>; Wed, 28 Nov 2001 09:10:15 -0500
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:9974 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S283049AbRK1OJg>; Wed, 28 Nov 2001 09:09:36 -0500
Date: Wed, 28 Nov 2001 09:09:28 -0500
From: Ben Collins <bcollins@debian.org>
To: Samuel Maftoul <maftoul@esrf.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ieee1394
Message-ID: <20011128090928.I23907@visi.net>
In-Reply-To: <20011128103256.A28083@pcmaftoul.esrf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011128103256.A28083@pcmaftoul.esrf.fr>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 10:32:56AM +0100, Samuel Maftoul wrote:
> Hello everyone,
>         Still me with my ieee1394 problems :)
> 
> Workaround: My goal is to make ieee1394 HardDisk  work in a production 
> environment:
> 	User come on a machine, plug his disk, store his (experience 
> 	results) datas on it, unplugs it and go away with it in his home
> 	institute where he processes his datas.

I don't see any mention of the kernel version you are using, nor about
the specific ohci chipset, or the hardware (ppc, i386?).

Give me some details. I don't see this issue right now, but I'm using
linux1394 CVS.


Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
