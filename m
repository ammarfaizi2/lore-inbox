Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVCGP6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVCGP6e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 10:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVCGP6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 10:58:34 -0500
Received: from imag.imag.fr ([129.88.30.1]:35815 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261805AbVCGP57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 10:57:59 -0500
Message-ID: <422C7979.9050404@imag.fr>
Date: Mon, 07 Mar 2005 16:55:37 +0100
From: Raphael Jacquot <raphael.jacquot@imag.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050304
X-Accept-Language: en-us, en, fr-fr
MIME-Version: 1.0
To: Mateusz Berezecki <mateuszb@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Atheros wi-fi card drivers (?)
References: <422C7722.40301@gmail.com>
In-Reply-To: <422C7722.40301@gmail.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Mon, 07 Mar 2005 16:57:54 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mateusz Berezecki wrote:
> Hi list members,
> 
> I've been doing some reverse engineering of madwifi HAL (Hardware 
> Abstraction Layer) object file recently.
> I ended up with an almost complete source code for one chipset so far 
> and I was wondering if it is legal
> to publish such source code on the internet? The note on a card says it 
> is "protected by us patents <patents number list>".
> Does the patent apply to the reverse engineered source code, or just to 
> the hardware? Or is it even legal to create such source code?
> I would like to ask for some comments regarding this case. And let's say 
> the driver works, would it be included into kernel source ?
> 
> 
> 
> regards
> Mateusz Berezecki

as your name appears european, there are no software patents (yet ?) so 
you should be able to release that code as required for interoperability

however, IANAL

imho, the better solution is now for you to create and release a 
documentation of what does what in the chipset, so that *someone else* 
recreates the thing from scratch.

> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

