Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292957AbSBVT1d>; Fri, 22 Feb 2002 14:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292958AbSBVT1Y>; Fri, 22 Feb 2002 14:27:24 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:1296 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S292957AbSBVT1N>;
	Fri, 22 Feb 2002 14:27:13 -0500
Date: Fri, 22 Feb 2002 16:26:42 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Christoph Hellwig <hch@caldera.de>
Cc: <lm@bitmover.com>, <hpa@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 bitkeeper repository
In-Reply-To: <20020222160657.A7914@caldera.de>
Message-ID: <Pine.LNX.4.33L.0202221625480.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, Christoph Hellwig wrote:

> the Linux 2.4 repository at linux.bkbbits.net is orphaned short after
> it got created.  Ist there any chance we could see continguous checkins
> for it?
>
> I think it might be a good idea to get it automatically checked in once
> Marcelo uploads a new (pre-) patch as part of the kernel.org
> notification procedure (is this possible, Peter?).
>
> If there is no way to automate it I would volunteer to do the checkins,
> but for that I'd need write permissions to the repository.

I've got a script here which pretty much automates the
checkins of incremental patches, it should be trivial
for Peter to call that from his script that creates the
incremental diffs.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

