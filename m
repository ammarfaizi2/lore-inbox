Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274133AbSITAey>; Thu, 19 Sep 2002 20:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274173AbSITAex>; Thu, 19 Sep 2002 20:34:53 -0400
Received: from hosting1.globalone.net.co ([216.72.142.131]:24206 "EHLO
	Sunny.noldata.com") by vger.kernel.org with ESMTP
	id <S274133AbSITAex>; Thu, 19 Sep 2002 20:34:53 -0400
From: glozano@noldata.com
Date: Thu, 19 Sep 2002 19:40:26 -0400 (EDT)
To: Neale Banks <neale@lowendale.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel message:   kernel: memory: cbc1eee0  what is?
In-Reply-To: <Pine.LNX.4.05.10209200857230.23877-100000@marina.lowendale.com.au>
Message-ID: <Pine.GSO.4.10.10209191939350.3621-100000@Sunny.noldata.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will check, I just transcribed it.

As soon as I get back into my home I will write you back

Rgds
and thanks a lot



___
Gustavo A. Lozano
Noldata
CTO

I know not with what weapons World War III will be fought,
but World War IV will be fought with sticks and stones. 
					Albert Einstein

On Fri, 20 Sep 2002, Neale Banks wrote:

> On 19 Sep 2002, Gustavo Lozano wrote:
> 
> > Hello
> > 
> > My 2.4.19 box today showed these 2 messages:
> > 
> > Hostname: kernel: memory: cbc1eee0
> > Hostname: kernel: memory: cbc1ef60
> > 
> > 
> > What is the signifance of such messages?
> 
> Hmm... you *sure* it wasn't "memory :" (note space before colon)?
> 
> If so, might be agpgart_fe's ambiguious printk (and disgustingly normal).
> I'll post a patch RSN.
> 
> HTH,
> Neale.
> 
> 

