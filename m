Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135945AbREDI2x>; Fri, 4 May 2001 04:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135919AbREDI2o>; Fri, 4 May 2001 04:28:44 -0400
Received: from femail4.sdc1.sfba.home.com ([24.0.95.84]:38282 "EHLO
	femail4.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S135945AbREDI2c>; Fri, 4 May 2001 04:28:32 -0400
Message-ID: <3AF26827.11B2A4A9@home.com>
Date: Fri, 04 May 2001 01:28:23 -0700
From: Seth Goldberg <bergsoft@home.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gordon Sadler <gbsadler1@lcisp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.5pre1 will not boot
In-Reply-To: <20010504030146.A15506@debian-home.lcisp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gordon Sadler wrote:
> 
> On Fri, May 04, 2001 at 12:43:22AM -0700, Seth Goldberg wrote:
> > Hi,
Hi,

 Have you tried compiling ther kernel with Athlon optimiztions turned
off (try
compiling for a K6-II[I])?  The has stopped the same thing from
happening on
my system and those of a few other people.

 --S


> >
> >    What hardware are you running?
> >
> AMD Duron 800
> Epox 8KTA3 m/b
> VIA KT133A AGPSet (KT133A+VT82C686B)
> 128 MB pc100 brandname SDRAM
> Inter etherexpress100
> Nvidia Riva TNT (orig.)
> Quantum FB LP LM20.5
> 
> Full details available in previous oops report for 2.4.4. Didn't see
> point of posting lspci -vvv, /proc/... again so soon. System here hasn't
> changed.
> 
> Thanks
> 
> Gordon Sadler
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
