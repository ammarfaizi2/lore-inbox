Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291372AbSBXVdI>; Sun, 24 Feb 2002 16:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290184AbSBXVct>; Sun, 24 Feb 2002 16:32:49 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:19214 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291370AbSBXVcg>;
	Sun, 24 Feb 2002 16:32:36 -0500
Date: Sun, 24 Feb 2002 18:32:09 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: <nick@snowman.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Troy Benjegerdes <hozer@drgw.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <Pine.LNX.4.21.0202241624330.10803-100000@ns>
Message-ID: <Pine.LNX.4.33L.0202241831330.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Feb 2002 nick@snowman.net wrote:

> None of the chipsets that supported VLB had more than one buss.  What
> I don't know is some idiot may have built a VLB-VLB bridge, but I
> doubt it.

There are PCI-VLB bridges.  Though it's unlikely, it may be
possible that there are systems with multiple such bridges
around... ;)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

