Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278206AbRJWT7k>; Tue, 23 Oct 2001 15:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278207AbRJWT7a>; Tue, 23 Oct 2001 15:59:30 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:47629 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S278206AbRJWT7W>;
	Tue, 23 Oct 2001 15:59:22 -0400
Date: Tue, 23 Oct 2001 17:59:39 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: bill davidsen <davidsen@tmr.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Q] pivot_root and initrd
In-Reply-To: <bWjB7.3869$Mm5.657055903@newssvr17.news.prodigy.com>
Message-ID: <Pine.LNX.4.33L.0110231759020.3690-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2001, bill davidsen wrote:
> In article <9r4c24$g2k$1@cesium.transmeta.com>,
> H. Peter Anvin <hpa@zytor.com> wrote:
>
> | The right thing is to get rid of the old initrd compatibility cruft,
> | but that's a 2.5 change.
>
>   Get rid of??? As long as you have some equivalent capability to get
> the system up.

pivot_root(2) in combination with pivot_root(8)

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

