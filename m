Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276653AbRJBUAz>; Tue, 2 Oct 2001 16:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276659AbRJBUAp>; Tue, 2 Oct 2001 16:00:45 -0400
Received: from cabal.xs4all.nl ([213.84.101.140]:30163 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S276653AbRJBUAb>;
	Tue, 2 Oct 2001 16:00:31 -0400
Date: Tue, 2 Oct 2001 22:00:53 +0200
From: Wichert Akkerman <wichert@cistron.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-lvm@sistina.com
Subject: Re: partition table read incorrectly
Message-ID: <20011002220053.H14582@wiggy.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, linux-lvm@sistina.com
In-Reply-To: <20011002202934.G14582@wiggy.net> <E15oUUf-0005Xw-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15oUUf-0005Xw-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Alan Cox wrote:
> Does it complain about wrong block sizes ?

No
 
> The partition code will look for tables. That bit is fine

If that bit is fine then how can it differ in opinion from fdisk?

> The exact error would be good too

 I/O error: dev 08:11, sector 0

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
