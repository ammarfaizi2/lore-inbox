Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317708AbSGVPnW>; Mon, 22 Jul 2002 11:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317709AbSGVPnW>; Mon, 22 Jul 2002 11:43:22 -0400
Received: from smtp.acn.pl ([212.76.33.20]:46133 "EHLO mail.astercity.net")
	by vger.kernel.org with ESMTP id <S317708AbSGVPnU>;
	Mon, 22 Jul 2002 11:43:20 -0400
Subject: Re: Athlon XP 1800+ segemntation fault
From: Karol Olechowski <karol_olechowski@acn.waw.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1027341850.31782.16.camel@irongate.swansea.linux.org.uk>
References: <20020722133259.A1226@acc69-67.acn.pl> 
	<1027341850.31782.16.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 22 Jul 2002 17:46:29 +0200
Message-Id: <1027352789.1655.41.camel@alpha>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 14:44, Alan Cox wrote:
> On Mon, 2002-07-22 at 14:32, Karol Olechowskii wrote:
> > Hello 
> > 
> > Few days ago I've bought new processor Athlon XP 1800+ to my computer
> > (MSI K7D Master with 256 MB PC2100 DDR).Before that I've got Athlon ThunderBird
> > 900 processor and everything had been working well till I change to the new one.
> > Now for every few minutes I've got segmetation fault or immediate system reboot.
> > Could anyone tell me what's goin' on?
> 
> > nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2960  Tue May 14 07:41:42 PDT 2002
> > devfs_register(nvidiactl): could not append to parent, err: -17
> > devfs_register(nvidia0): could not append to parent, err: -17
> 
> Please duplicate the problem without ever loading the NVidia nvdriver
> from a clean boot. If you can't do that then talk to Nvidia, if you can
> then post new crash data here
> 

Hi Alan

I've do exactly what You wrote me.(remove NVidia driver) but it isn't
change anything.In the moment of writing this letter a try to compile
kernel and I can't even do this.System hangs or logout console session
or write something like this

gcc: Internal compiler error:
program cc1 got fatal signal 11
make[3] : ***[igmp.o] Error 1

under X

Application "gkrellm" (process bal bal) has crashed
due to a fatal error
(Segmenataion fault)


It's something strange with my computer cause not only Linux hangs.On
the other disk I've got Win XP and it also hangs ( blue screen,memory
dump and things like that...).Almost every component is a brand
new(mother board, processor, memory, video card, power supply)

I've look at the logs and everything looks good.Please send me any tip,
what I can do with this stuff

best regards

Karol Olechowski





