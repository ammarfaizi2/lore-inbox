Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135399AbQLOArs>; Thu, 14 Dec 2000 19:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135173AbQLOAri>; Thu, 14 Dec 2000 19:47:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:47822 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135399AbQLOArb>;
	Thu, 14 Dec 2000 19:47:31 -0500
Date: Thu, 14 Dec 2000 19:17:03 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Miquel van Smoorenburg <miquels@traveler.cistron-office.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linus's include file strategy redux
In-Reply-To: <91bnoc$vij$2@enterprise.cistron.net>
Message-ID: <Pine.GSO.4.21.0012141916270.10441-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 15 Dec 2000, Miquel van Smoorenburg wrote:

> In article <NBBBJGOOMDFADJDGDCPHIENJCJAA.law@sgi.com>,
> LA Walsh <law@sgi.com> wrote:
> >Which works because in a normal compile environment they have /usr/include
> >in their include path and /usr/include/linux points to the directory
> >under /usr/src/linux/include.
> 
> No, that a redhat-ism.

Not even all versions of redhat do that.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
