Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbULTVKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbULTVKK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 16:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbULTVKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 16:10:10 -0500
Received: from king.bitgnome.net ([66.207.162.30]:31203 "EHLO
	king.bitgnome.net") by vger.kernel.org with ESMTP id S261643AbULTVKB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 16:10:01 -0500
Date: Mon, 20 Dec 2004 15:09:09 -0600
From: Mark Nipper <nipsy@bitgnome.net>
To: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD64: timer is running twice as fast as it should (again??)
Message-ID: <20041220210909.GA49579@king.bitgnome.net>
References: <87ekhkhf1j.fsf@londo.ultra.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ekhkhf1j.fsf@londo.ultra.csn.tu-chemnitz.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Dec 2004, Enrico Scholz wrote:
> with 2.6 kernels, the timer on AMD64 runs exactly twice as fast as
> expected. E.g. 'sleep 10' returns after 5 seconds external time.
> 
> This behavior was seen with Fedora Core 3 kernel 2.6.9-1.681_FC3 and
> 2.6.10-rc3-bk13 (both x86_64 mode).
> 
> System information can be found at
>                 http://www.tu-chemnitz.de/~ensc/hw/amd64

	Seem like something specific to Fedora or the bk branch
then because I'm running 2.6.10-rc3 under x86_64 and it sleeps as
long as it should.

-- 
Mark Nipper                                                e-contacts:
4475 Carter Creek Parkway                           nipsy@bitgnome.net
Apartment 724                               http://nipsy.bitgnome.net/
Bryan, Texas, 77802-4481           AIM/Yahoo: texasnipsy ICQ: 66971617
(979)575-3193                                      MSN: nipsy@tamu.edu

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GG/IT d- s++:+ a- C++$ UBL++++$ P--->+++ L+++$ !E---
W++(--) N+ o K++ w(---) O++ M V(--) PS+++(+) PE(--)
Y+ PGP t+ 5 X R tv b+++@ DI+(++) D+ G e h r++ y+(**)
------END GEEK CODE BLOCK------

---begin random quote of the moment---
Whose woods these are I think I know.
His house is in the village though;
He will not see me stopping here
To watch his woods fill up with snow.

My little horse must think it queer
To stop without a farmhouse near
Between the woods and frozen lake
The darkest evening of the year.

He gives his harness bells a shake
To ask if there is some mistake.
The only other sound's the sweep
Of easy wind and downy flake.

The woods are lovely, dark and deep.
But I have promises to keep,
And miles to go before I sleep,
And miles to go before I sleep.

 -- Robert Frost, _New Hampshire: A Poem with Notes and Grace
    Notes_, 1923
----end random quote of the moment----
