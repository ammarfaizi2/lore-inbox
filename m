Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289489AbSAJPMr>; Thu, 10 Jan 2002 10:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289488AbSAJPMh>; Thu, 10 Jan 2002 10:12:37 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:45316 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289489AbSAJPM0>;
	Thu, 10 Jan 2002 10:12:26 -0500
Date: Thu, 10 Jan 2002 13:12:13 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Oliver Feiler <kiza@gmx.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: HPT370 controller set wrong udma mode
In-Reply-To: <20020110160718.A296@gmxpro.net>
Message-ID: <Pine.LNX.4.33L.0201101307480.2985-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Oliver Feiler wrote:

> 	My onboard (Epox 8KTA3+) HPT370 controller seems to set the
> wrong udma transfer mode for the attached drive. Resulting in BadCRC
> errors. The drive attached is an IBM DJSA-205 2.5" drive. It can do
> udma4 max.

> Kernel is 2.4.16

I've heard this problem is fixed with Andre Hedrik's new
IDE drivers, available from:
	http://www.linuxdiskcert.org/

cheers,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

