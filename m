Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262110AbRENCrg>; Sun, 13 May 2001 22:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262183AbRENCr0>; Sun, 13 May 2001 22:47:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33968 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262110AbRENCrQ>;
	Sun, 13 May 2001 22:47:16 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15103.18224.265350.877968@pizda.ninka.net>
Date: Sun, 13 May 2001 19:47:12 -0700 (PDT)
To: Pekka Savola <pekkas@netcore.fi>
Cc: <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: IPv6: the same address can be added multiple times
In-Reply-To: <Pine.LNX.4.33.0105132319120.3026-100000@netcore.fi>
In-Reply-To: <200105131759.VAA27768@ms2.inr.ac.ru>
	<Pine.LNX.4.33.0105132319120.3026-100000@netcore.fi>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pekka Savola writes:
 > But it still looks dirty.  Also, it's easier to add it many times by
 > mistake; IPv4 addresses do not allow this.  And as you have to remove them
 > N times too, this may create even more confusion.

There is this growing (think growing as in "fungus") set of thinking
that just because something can be misused, this is an argument
against it even existing.

I think this is wrong.  I'm seeing it a lot, especially on this list,
and it's becomming a real concern at least to me.

Most of the time the argument goes like:

1: "Well, we allow this because you can do usefull things X Y and
    Z as a result."

2: "Yeah, but this also lets you do stupid things like A B and
    C."

   translation: "It hurts when I do A B or C"

Most people know the appropriate response for the translation of
#2 ;-)

Later,
David S. Miller
davem@redhat.com
