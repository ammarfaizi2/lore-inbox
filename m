Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292968AbSBVTwF>; Fri, 22 Feb 2002 14:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292976AbSBVTvt>; Fri, 22 Feb 2002 14:51:49 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:38417 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S292970AbSBVTt2>;
	Fri, 22 Feb 2002 14:49:28 -0500
Date: Fri, 22 Feb 2002 16:49:07 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Christoph Hellwig <hch@caldera.de>, <lm@bitmover.com>, <hpa@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 bitkeeper repository
In-Reply-To: <20020222193723.GL719@opus.bloom.county>
Message-ID: <Pine.LNX.4.33L.0202221648320.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, Tom Rini wrote:

> If you have a pristine tree, adding incremental diffs is:
> bk import -tpatch ../patch-2.4.X-preY-preZ . && bk tag v2.4.X-preZ
> Which is what I do for the PPC's kernel.org-only tree(s).

You forgot about setting the proper BK_USER, BK_HOST and
'bk comment' commands ;)

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

