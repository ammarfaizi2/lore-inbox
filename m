Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289241AbSAVVMj>; Tue, 22 Jan 2002 16:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289306AbSAVVM3>; Tue, 22 Jan 2002 16:12:29 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:18701 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289293AbSAVVMR>;
	Tue, 22 Jan 2002 16:12:17 -0500
Date: Tue, 22 Jan 2002 19:12:04 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Chris Mason <mason@suse.com>, Andreas Dilger <adilger@turbolabs.com>,
        Shawn Starr <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>,
        <ext2-devel@lists.sourceforge.net>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4DCC49.1080202@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201221910500.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, Hans Reiser wrote:

> Why does it need to know how suitable it is compared to the other
> subcaches?  It just ages X pages,

How the hell is the filesystem supposed to age pages ?

The filesystem DOES NOT KNOW how often pages are used,
so it cannot age the pages.

End of thread.

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

