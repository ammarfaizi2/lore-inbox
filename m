Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268188AbRGZQNz>; Thu, 26 Jul 2001 12:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268231AbRGZQNp>; Thu, 26 Jul 2001 12:13:45 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:58634 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268188AbRGZQNd>; Thu, 26 Jul 2001 12:13:33 -0400
Date: Thu, 26 Jul 2001 13:13:34 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: Christoph Hellwig <hch@ns.caldera.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <20010726174844.W17244@emma1.emma.line.org>
Message-ID: <Pine.LNX.4.33L.0107261311210.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Matthias Andree wrote:
> Christoph Hellwig schrieb am Donnerstag, den 26. Juli 2001:
>
> > So they rely on undocumented and non standadisized semantics of some
> > implementations.  I'd call this buggy.
>
> If each in the set of "supported systems" document this
> behaviour for themselves, there is no bug.

The MTA depends on behaviour which is undefined. Now you
want to go blame the OS ?

> Go tell your opinion to those people that refuse to wrap their
> rename/link calls with open()/fsync() calls to the respective parents,
> particularly Daniel J. Bernstein, Wietse Z. Venema, among others. I
> don't possibly know all MTAs.

If you care about your email, probably you should either
teach these people about standards like POSIX or SuS
(and tell them to not rely on undefined behaviour) or
switch to an MTA which isn't broken in various ways ;)

cheers,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

