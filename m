Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130311AbRA0Ste>; Sat, 27 Jan 2001 13:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130460AbRA0StZ>; Sat, 27 Jan 2001 13:49:25 -0500
Received: from mail.diligo.fr ([194.153.78.251]:34061 "EHLO mail.diligo.fr")
	by vger.kernel.org with ESMTP id <S130311AbRA0StU>;
	Sat, 27 Jan 2001 13:49:20 -0500
Date: Sat, 27 Jan 2001 19:46:59 +0100
From: patrick.mourlhon@wanadoo.fr
To: Paul Jakma <paulj@itg.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: routing between different subnets on same if.
Message-ID: <20010127194659.A1326@MourOnLine.dnsalias.org>
Reply-To: patrick.mourlhon@wanadoo.fr
In-Reply-To: <20010127193234.A1166@MourOnLine.dnsalias.org> <Pine.LNX.4.32.0101271839130.15191-100000@rossi.itg.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.32.0101271839130.15191-100000@rossi.itg.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

did you install routed on the linux machine ?

On Sat, 27 Jan 2001, Paul Jakma wrote:

> On Sat, 27 Jan 2001 patrick.mourlhon@wanadoo.fr wrote:
> 
> > Hi Paul,
> >
> > I just think you might look for aliasing on your linux box.
> >
> 
> i have the aliasing, the aliased machine can ping IP's on both
> subnets. The machine is supposed to be a router though and clients on
> both subnets are setup to use it as their default router.. but it
> doesn't route... it notices that both IP's are on the same link and so
> just sends ICMP redirects. which doesn't help. :(
> 
> i need linux to completely route between 2 IP's even though they are
> on the same link.
> 
> regards,
> 
> --paulj
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
