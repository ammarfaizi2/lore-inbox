Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280690AbRKNQuE>; Wed, 14 Nov 2001 11:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280703AbRKNQty>; Wed, 14 Nov 2001 11:49:54 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:14087 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S280690AbRKNQtp>; Wed, 14 Nov 2001 11:49:45 -0500
Date: Wed, 14 Nov 2001 19:49:03 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Richard Henderson <rth@twiddle.net>, Donald Maner <donjr@maner.org>,
        "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Compile error 2.4.15-pre4 on alpha
Message-ID: <20011114194903.A8579@jurassic.park.msu.ru>
In-Reply-To: <C033B4C3E96AF74A89582654DEC664DB5576@aruba.maner.org> <3BF09ED5.54176F4F@mandrakesoft.com> <20011113165911.A1007@jurassic.park.msu.ru> <3BF2924C.B2213C1B@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BF2924C.B2213C1B@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Nov 14, 2001 at 10:48:28AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 10:48:28AM -0500, Jeff Garzik wrote:
> only cpu0?  on SMP, cpu1/2/3/4 are not shown?

They are supposed to be identical. Currently we're only
interested in a CPU type and number of processors.

Ivan.
