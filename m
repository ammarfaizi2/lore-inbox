Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268876AbRG0QnI>; Fri, 27 Jul 2001 12:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268888AbRG0Qm6>; Fri, 27 Jul 2001 12:42:58 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:47630 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268886AbRG0Qms>; Fri, 27 Jul 2001 12:42:48 -0400
Message-ID: <3B6199D1.AB5A250D@namesys.com>
Date: Fri, 27 Jul 2001 20:41:53 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>,
        Nikita Danilov <god@namesys.com>, Jeff Mahoney <jeffm@suse.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <E15Q9tU-0005vk-00@the-village.bc.nu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox wrote:

> Nobody needs conspiracies to not use reiserfs as their core fs, and until
> things like big endian support are cleanly resolved that isnt likely to
> change.
> 
> Alan
big endian support is resolved, there is a working patch for it by Jeff Mahoney, it passes all of
our tests, but it is a feature not a bug fix, and not something for a supposedly stabilizing kernel.

Nikita, you were supposed to send the big endian support and some other stuff in to Alan for testing
in the ac series, what is the status of patches that are supposed to be going to Alan?

Hans
