Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290431AbSAPOfQ>; Wed, 16 Jan 2002 09:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290430AbSAPOfG>; Wed, 16 Jan 2002 09:35:06 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:26530 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S290395AbSAPOey>; Wed, 16 Jan 2002 09:34:54 -0500
Date: Wed, 16 Jan 2002 16:32:58 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Christian Thalinger <e9625286@student.tuwien.ac.at>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: floating point exception
In-Reply-To: <1011182157.513.2.camel@sector17.home.at>
Message-ID: <Pine.LNX.4.44.0201161632001.23365-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jan 2002, Christian Thalinger wrote:

> Gnu C                  3.0.3
> Gnu make               3.79.1
> util-linux             2.11m
> mount                  2.11h
> modutils               2.4.11
> e2fsprogs              1.25
> reiserfsprogs          3.x.0b
> Linux C Library        2.2.4
> Dynamic linker (ldd)   2.2.4
> Linux C++ Library      3.0.2
> Procps                 2.0.7
> Net-tools              1.60
> Console-tools          0.2.3
> Sh-utils               2.0.11
> Modules Loaded         NVdriver sym53c8xx scsi_mod pwcx-i386 pwc rio500
> usb-ohci
>  usbcore w83781d eeprom i2c-proc i2c-amd756 i2c-isa binfmt_misc
> binfmt_aout ospm
> _processor ospm_system ospm_busmgr sercontrol lirc_i2c lirc_dev tuner
> tvaudio ms
> p3400 bttv videodev i2c-algo-bit i2c-core nfsd lockd sunrpc parport_pc
> lp parpor
> t via-rhine emu10k1 sound ac97_codec soundcore rtc

Can you also reproduce _without_ loading NVdriver, just to make everybody 
happy.

Thanks,
	Zwane Mwaikambo


