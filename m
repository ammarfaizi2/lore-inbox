Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131638AbRA0SmE>; Sat, 27 Jan 2001 13:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132094AbRA0Sly>; Sat, 27 Jan 2001 13:41:54 -0500
Received: from mail.diligo.fr ([194.153.78.251]:16653 "EHLO mail.diligo.fr")
	by vger.kernel.org with ESMTP id <S131638AbRA0Slm>;
	Sat, 27 Jan 2001 13:41:42 -0500
Date: Sat, 27 Jan 2001 19:39:17 +0100
From: patrick.mourlhon@wanadoo.fr
To: linux-kernel@vger.kernel.org
Subject: Re: routing between different subnets on same if.
Message-ID: <20010127193917.B1166@MourOnLine.dnsalias.org>
Reply-To: patrick.mourlhon@wanadoo.fr
In-Reply-To: <Pine.LNX.4.32.0101271742250.15191-100000@rossi.itg.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.32.0101271742250.15191-100000@rossi.itg.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I just think you might look at aliasing on the linux box..

ifconfig eth0:0 ...

this might help you do the think,

regards,

patrick mourlhon

On Sat, 27 Jan 2001, Paul Jakma wrote:

> i'm trying to get linux to do routing between 2 different subnets that
> are on the same physical interface, because windows hosts don't seem
> to accept the redirects.
> 
> how do i do it? how do i get linux to fully route between these
> subnets on behalf of clients? turn send_redirects off doesn't work,
> and nothing obvious shows up with 'ip route help'... (and there's no
> man page for it to tell me).
> 
> i'm using the RedHat 2.2.16 kernel.
> 
> regards,
> 
> --paulj
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
