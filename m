Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268559AbRG3V7h>; Mon, 30 Jul 2001 17:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268560AbRG3V71>; Mon, 30 Jul 2001 17:59:27 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:19719 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268559AbRG3V7N>; Mon, 30 Jul 2001 17:59:13 -0400
Date: Mon, 30 Jul 2001 18:59:17 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@caldera.de>, <linux-kernel@vger.kernel.org>,
        Vitaly Fertman <vitaly@namesys.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <3B65CC07.24E3EF4C@namesys.com>
Message-ID: <Pine.LNX.4.33L.0107301858350.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 31 Jul 2001, Hans Reiser wrote:
> Christoph Hellwig wrote:
> >
> > Nope.  It does a reiserfs_panic instead of letting the wrong arguments
> > slipping into lower layers and possibly on disk and thus corrupting data.
> >
> > And in my opinion correct data is much more worth than one crash more or
> > less (especially with a journaling filesystem).
>
> There is nothing like a distro maintainer overriding the design
> decisions made by the lead architect of a package, not believing
> that said architect knows what the fuck he is doing.

Are you actually saying you don't care about user's data,
or is it just my imagination ?

(I hope it's my imagination ...)

cheers,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

