Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbSKSOXF>; Tue, 19 Nov 2002 09:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265517AbSKSOXF>; Tue, 19 Nov 2002 09:23:05 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:63186 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S265513AbSKSOXE>; Tue, 19 Nov 2002 09:23:04 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 19 Nov 2002 16:06:25 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Javier Marcet <jmarcet@pobox.com>
Cc: linux-kernel@vger.kernel.org, Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [PATCH] bttv & 2.5.48
Message-ID: <20021119150625.GA13525@bytesex.org>
References: <20021118141328.GA10815@vana> <20021119132106.GA14615@jerry.marcet.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119132106.GA14615@jerry.marcet.dyndns.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This fixes the second of the errors, but not the missing
> AUDC_CONFIG_PINNACLE I get first:
> 
> drivers/media/video/bttv-cards.c: In function AUDC_CONFIG_PINNACLE' 
> undeclared (first use in this function)

> Any idea where the error might be?

http://bytesex.org/patches/2.5/ has patches for this and other issues.

Files starting with digits are the individual patches,
patch-2.5.48-kraxel.gz is the "all in one" package.

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
