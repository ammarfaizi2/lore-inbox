Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291460AbSBSQJ6>; Tue, 19 Feb 2002 11:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291455AbSBSQJs>; Tue, 19 Feb 2002 11:09:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27665 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291449AbSBSQJa>;
	Tue, 19 Feb 2002 11:09:30 -0500
Message-ID: <3C7278B7.C0E4D126@mandrakesoft.com>
Date: Tue, 19 Feb 2002 11:09:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH *] new struct page shrinkage
In-Reply-To: <Pine.LNX.4.33L.0202191131050.1930-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> I've also pulled the thing up to
> your latest changes from linux.bkbits.net so you should be
> able to just pull it into your tree from:

Note that with BK, unlike CVS, it is not required that you update to the
latest Linus tree before he can pull.

It is only desired that you do so if there is an actual conflict you
need to resolve...

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
