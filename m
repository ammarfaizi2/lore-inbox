Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263329AbTCNNmC>; Fri, 14 Mar 2003 08:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263330AbTCNNmC>; Fri, 14 Mar 2003 08:42:02 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30418
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263329AbTCNNmB>; Fri, 14 Mar 2003 08:42:01 -0500
Subject: Re: pcmcia-ide hang with 2.4.21-pre
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Dreher <dreher@math.tu-freiberg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <200303132358.15629.dreher@math.tu-freiberg.de>
References: <200303132358.15629.dreher@math.tu-freiberg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047654024.29544.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Mar 2003 15:00:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 22:58, Michael Dreher wrote:
> Hello all,
> 
> I get a hang as soon as I insert a pcmcia-cd-rom drive into my 
> vaio picturebook (ALi/Transmeta). 
> The box is just dead, after some seconds. 100% reproducible.
> No sysrq works, nothing in the logs. 
> 
> external pcmcia-cs from David Hinds, version 3.2.4 (February 26)
> 2.4.20 is OK
> 2.4.21-pre1 and later hang.

Which kernel pcmcia code are you using ? The supplied kernel code
or the Dave Hinds extras. (Both of course use the pcmcia user space)

