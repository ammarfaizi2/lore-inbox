Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279688AbRKAUOr>; Thu, 1 Nov 2001 15:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279700AbRKAUO2>; Thu, 1 Nov 2001 15:14:28 -0500
Received: from anime.net ([63.172.78.150]:55300 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S279688AbRKAUOQ>;
	Thu, 1 Nov 2001 15:14:16 -0500
Date: Thu, 1 Nov 2001 12:14:02 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Remco Post <r.post@sara.nl>
cc: Mark Clayton <mark@brown-pelican.com>, <linux-kernel@vger.kernel.org>
Subject: Re: unnumbered interfaces? 
In-Reply-To: <200111011522.QAA22531@zhadum.sara.nl>
Message-ID: <Pine.LNX.4.30.0111011213020.12216-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001, Remco Post wrote:
> Having said this, unnumbered interfaces are quite rare in ip networks, most
> backbones use ip addresses on all of the interfaces of their routers. (do a
> traceroute to anywhere, you'll find very few hops that show no ip address).

unnumbered interfaces are more common than you think -- most dialup ppp
servers use them. iirc the linux pppd supports them too.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

