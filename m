Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUHGQRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUHGQRI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 12:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUHGQRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 12:17:08 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:23747 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S263429AbUHGQRF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 12:17:05 -0400
Date: Sat, 7 Aug 2004 12:12:27 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Mitchel Sahertian <mitchel@sahertian.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aes512 cryptoloop support -> gone?
Message-ID: <20040807161227.GO23994@certainkey.com>
References: <1088165608.6399.20.camel@xinu.sahe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088165608.6399.20.camel@xinu.sahe.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct,

Because AES512 is a fictitious cipher.  There is only "aes128" "aes192" and
"aes256"

Cheers,

JLC

On Fri, Jun 25, 2004 at 02:13:29PM +0200, Mitchel Sahertian wrote:
> With some 2.4.x kernel i created a crypto loopback with an aes512
> cipher. Afair i was able to use it with 2.5.x too. But at some moment
> 512bit support was removed and as of now, 256 is the max. I guess
> support was removed for legal reasons or so..
> 
> Are there any patches for 2.6/aesloop/cryptoloop or "tools" to read or
> convert my loopback device?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
