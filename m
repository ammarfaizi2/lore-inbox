Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282771AbRLBGB1>; Sun, 2 Dec 2001 01:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282772AbRLBGBI>; Sun, 2 Dec 2001 01:01:08 -0500
Received: from femail4.sdc1.sfba.home.com ([24.0.95.84]:12782 "EHLO
	femail4.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S282771AbRLBGBF>; Sun, 2 Dec 2001 01:01:05 -0500
Date: Sun, 2 Dec 2001 01:00:59 -0500
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: Re: File system Corruption with 2.4.16
Message-ID: <20011202010059.A9744@zero>
In-Reply-To: <3C0954D5.6AA3532B@ruault.com> <3C09580F.5F323195@pobox.com> <3C095B0B.7EA478C1@ruault.com> <003601c17ac2$7a8dec10$f5976dcf@nwfs> <3C096DB3.204CE41C@pobox.com> <001e01c17acb$a44b69c0$f5976dcf@nwfs> <20011202023145.A1628@emeraude.kwisatz.net> <3C09B3FA.61777E84@ruault.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C09B3FA.61777E84@ruault.com>; from ce@ruault.com on Sat, Dec 01, 2001 at 08:54:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 08:54:18PM -0800, Charles-Edouard Ruault wrote:
> The symlink problem you're reporting is exactly what i've been experiencing among
> other things ...
> on both systems i had multiple ext2 partitions and one reseirfs partition.

are you seeing corruption on the reiserfs? have you run reiserfsck?

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
