Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263359AbTCNNti>; Fri, 14 Mar 2003 08:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263360AbTCNNti>; Fri, 14 Mar 2003 08:49:38 -0500
Received: from karpfen.mathe.tu-freiberg.de ([139.20.24.195]:11392 "EHLO
	karpfen.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id <S263359AbTCNNth> convert rfc822-to-8bit; Fri, 14 Mar 2003 08:49:37 -0500
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Subject: Re: pcmcia-ide hang with 2.4.21-pre
Date: Fri, 14 Mar 2003 15:03:03 +0100
User-Agent: KMail/1.5
References: <200303132358.15629.dreher@math.tu-freiberg.de> <1047654024.29544.12.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1047654024.29544.12.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303141503.03732.dreher@math.tu-freiberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Freitag, 14. März 2003 16:00 wrote Alan Cox:
> On Thu, 2003-03-13 at 22:58, Michael Dreher wrote:
> > Hello all,
> >
> > I get a hang as soon as I insert a pcmcia-cd-rom drive into my
> > vaio picturebook (ALi/Transmeta).
> > The box is just dead, after some seconds. 100% reproducible.
> > No sysrq works, nothing in the logs.
> >
> > external pcmcia-cs from David Hinds, version 3.2.4 (February 26)
> > 2.4.20 is OK
> > 2.4.21-pre1 and later hang.
>
> Which kernel pcmcia code are you using ? The supplied kernel code
> or the Dave Hinds extras. (Both of course use the pcmcia user space)

I use everything from David Hinds. His user space as well as his
kernel modules.
