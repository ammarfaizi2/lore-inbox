Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313577AbSDPE1s>; Tue, 16 Apr 2002 00:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313595AbSDPE1s>; Tue, 16 Apr 2002 00:27:48 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:47368 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S313577AbSDPE1r>;
	Tue, 16 Apr 2002 00:27:47 -0400
Date: Tue, 16 Apr 2002 01:27:26 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        William Lee Irwin III <wli@holomorphy.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
In-Reply-To: <20020416013016.GA23513@matchmail.com>
Message-ID: <Pine.LNX.4.44L.0204160126510.1960-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 02:44:58AM +0200, Andrea Arcangeli wrote:
> On Mon, Apr 15, 2002 at 04:20:58PM -0700, William Lee Irwin III wrote:
> > I won't scream too loud, but I think it's pretty much done right as is.
>
> Regardless if that's the cleaner implementation or not, I don't see much
> the point of merging those cleanups in 2.4 right now: it won't make any
> functional difference to users and it's only a self contained code
> cleanup, while other patches that make a runtime difference aren't
> merged yet.

Sorry to say it, but if you want patches to be merged, why
don't you submit them ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

