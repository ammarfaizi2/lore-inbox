Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312426AbSDCWYu>; Wed, 3 Apr 2002 17:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312425AbSDCWYk>; Wed, 3 Apr 2002 17:24:40 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:7183 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S312418AbSDCWY2>;
	Wed, 3 Apr 2002 17:24:28 -0500
Date: Wed, 3 Apr 2002 19:24:07 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Gerd Knorr <kraxel@bytesex.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <Pine.LNX.3.95.1020403171242.12859A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44L.0204031922570.18660-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002, Richard B. Johnson wrote:

> Well, you can't have it both ways. If you want the world to use
> Linux, then the companies that spend their money making programs
> and drivers that work with Linux are going to have to be able
> to keep their own hard-earned code from their competitors, or the
> companies that hire the Engineers that write the code will soon
> be out-of-business, their work having been stolen by others.

That's the perfect argument for making some symbols GPL-only,
after all Redhat, SuSE, Conectiva, etc. wouldn't want to have
vmware and Veritas use their work without giving anything back ...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

