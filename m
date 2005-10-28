Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbVJ1HSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbVJ1HSv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVJ1HSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:18:51 -0400
Received: from king.bitgnome.net ([70.84.111.244]:15816 "EHLO
	king.bitgnome.net") by vger.kernel.org with ESMTP id S965151AbVJ1HSu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:18:50 -0400
Date: Fri, 28 Oct 2005 02:18:37 -0500
From: Mark Nipper <nipsy@bitgnome.net>
To: Chaitanya Hazarey <c.v.hazarey@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why dependance of linux kernel on linux-kernel-headers package ?
Message-ID: <20051028071836.GA28455@king.bitgnome.net>
References: <9a9abfb40510280009v3f340f9dve02d6ffa110ae856@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a9abfb40510280009v3f340f9dve02d6ffa110ae856@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Oct 2005, Chaitanya Hazarey wrote:
> I would like to know about some things regarding the current scheme of
> things in the linux kernel compilation procedure on Debian machines.

        Which means you need to ask some Debian people and not
the Linux kernel developers directly.

        Generally speaking I have no troubles using make-kpkg
from the Debian package kernel-package to build my own custom
kernels, Debian packaged third-party modules (such as the nVidia
drivers) and non-packaged modules such as the VMware modules.

        But if you want to talk about it any further, reply to me
off list or in a Debian based forum as this is not the place for
a discussion that is Debian specific.

-- 
Mark Nipper                                                e-contacts:
832 Tanglewood Drive                                nipsy@bitgnome.net
Bryan, Texas 77802-4013                     http://nipsy.bitgnome.net/
(979)575-3193                      AIM/Yahoo: texasnipsy ICQ: 66971617

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GG/IT d- s++:+ a- C++$ UBL++++$ P--->+++ L+++$ !E---
W++(--) N+ o K++ w(---) O++ M V(--) PS+++(+) PE(--)
Y+ PGP t+ 5 X R tv b+++@ DI+(++) D+ G e h r++ y+(**)
------END GEEK CODE BLOCK------

---begin random quote of the moment---
'Whenever a politician starts talking about "the children,"
keep one eye on your wallet and the other on your liberty.'
 -- anonymous
----end random quote of the moment----
