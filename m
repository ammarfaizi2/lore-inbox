Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316492AbSEOUkv>; Wed, 15 May 2002 16:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316498AbSEOUku>; Wed, 15 May 2002 16:40:50 -0400
Received: from mail.spylog.com ([194.67.35.220]:6046 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S316492AbSEOUks>;
	Wed, 15 May 2002 16:40:48 -0400
Date: Thu, 16 May 2002 00:40:39 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrea Arcangeli <andrea@suse.de>, "Justin T. Gibbs" <gibbs@scsiguy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Adaptec Aic7xxx driver & 2.4.19pre8aa2
Message-ID: <20020515204039.GA31314@spylog.ru>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andrea Arcangeli <andrea@suse.de>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020515164802.GG25593@dualathlon.random> <E1780jL-0002Ac-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan Cox,

Once you wrote about "Re: Adaptec Aic7xxx driver & 2.4.19pre8aa2":
> > > >Hardware motherboard: Intel "Lancewood" L440GX, SCSI integrated, last BIOS/BMC
> 
> 440GX

yes
 
> > search across the 2.4.19pre patches (from pre2 to pre8) that would limit
> > the bug to a certain diff. thanks,
> 
> No need. The 440GX stuff is a known disaster area. You must use APIC support
> on those and Intel doesn't want to be helpful on non APIC stuff.

I always use APIC, tried it to switch off (earlier), was too, as now with
included APIC.


#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_1GB is not set
# CONFIG_2GB is not set
# CONFIG_3GB is not set
CONFIG_05GB=y
CONFIG_HIGHIO=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y


-- 
bye.
Andrey Nekrasov, SpyLOG.
