Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293579AbSBZLnS>; Tue, 26 Feb 2002 06:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293581AbSBZLnI>; Tue, 26 Feb 2002 06:43:08 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:28680 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293579AbSBZLm5>;
	Tue, 26 Feb 2002 06:42:57 -0500
Date: Tue, 26 Feb 2002 08:42:47 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linux <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the
 tree
In-Reply-To: <187757891.1014669202@[10.10.2.3]>
Message-ID: <Pine.LNX.4.33L.0202260841030.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Martin J. Bligh wrote:
> >> rmap still sucks on large systems though.
> >
> > But this is not a fundamental issue, it's implementation.
> > Whereas non-rmap will always suck on large systems, for
> > fundamental reasons that are unrelated to the quality of
> > the implementation.
>
> Absolutely ... it's just not quite finished yet. I'm
> convinced it'll be a major win for everyone in the end,
> I just squirm a little when I see people advocating it
> going into the mainline right now.

To be honest, so do I.

We've seen Linus merge a large chunk of VM code into
2.4 twice now, both merges gave problems.

The way to start merging stuff is to add useful pieces
of code one by one, like Al Viro is slowly merging a
rewrite of the VFS without anyone noticing ;)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

