Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290472AbSBKVg4>; Mon, 11 Feb 2002 16:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290490AbSBKVgq>; Mon, 11 Feb 2002 16:36:46 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:19210 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290472AbSBKVgf>;
	Mon, 11 Feb 2002 16:36:35 -0500
Date: Mon, 11 Feb 2002 19:36:28 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Andrew Rodland <arodland@noln.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] rmap based VM 12e
In-Reply-To: <20020211084426.21907cfb.arodland@noln.com>
Message-ID: <Pine.LNX.4.33L.0202111935400.12554-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2002, Andrew Rodland wrote:
> On Mon, 11 Feb 2002 00:15:24 -0200 (BRST)
> Rik van Riel <riel@conectiva.com.br> wrote:
>
> > The fifth maintenance release of the 12th version of the reverse
> > mapping based VM is now available.
>
> I don't have any evil benchmarks to run, but it works just great on my
> little laptop (192mb ram, 73mb swap). The O(1)-K3 patch against 12c also
> applies fine, and does the right thing.
>
> This is cool-beans stuff. Makes me glad that I'm just a bit adventurous.

No evil benchmarks required.  If this patch makes your machine
behave better for what you do ... that's all we need ;)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

