Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318878AbSH1P3P>; Wed, 28 Aug 2002 11:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318879AbSH1P3P>; Wed, 28 Aug 2002 11:29:15 -0400
Received: from syndetix.com ([204.134.124.201]:56995 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S318878AbSH1P3N>;
	Wed, 28 Aug 2002 11:29:13 -0400
Message-ID: <3D6CE241.3060802@zianet.com>
Date: Wed, 28 Aug 2002 08:46:25 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mucharek@o2.pl
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug when compiled \"under\" Athlon
References: <20020828064718.225E4C22A@rekin.go2.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cd /usr/src/linux
make modules
make modules_install

mucharek@o2.pl wrote:

>1. After compiling the kernel to work with AMD Athlons', some modules 
>do not load.
>2. After compiling the kernel, to work with "Athlon/Duron" some 
>modules lik ppp* usb* do not get modeprobed or insmoded. I get an 
>error message about a "unresolved definition: _mmxmem_cpy".
>3. kernel, Athlon, compiling, insmod, modprobe, ppp.o, usbcore.o
>4. Kernel version: 2.4.19
>5. Environment: Slackware 8.0, Athlon 900MHz, 512 MB RAM, GeForce2 
>GTS 64MB DDR, AC97 soundcard, mainboard based on VIA chipsets.
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>



