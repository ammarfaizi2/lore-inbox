Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267335AbUIJJwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267335AbUIJJwi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 05:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267352AbUIJJuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 05:50:16 -0400
Received: from p5089E239.dip.t-dialin.net ([80.137.226.57]:1540 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S267335AbUIJJpp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 05:45:45 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Re: 2.6.9-rc1-mm4, visor.c, Badness in usb_unlink_urb
Date: Fri, 10 Sep 2004 11:45:42 +0200
User-Agent: KMail/1.7
Cc: Greg KH <greg@kroah.com>
References: <20040910082601.GA32746@gamma.logic.tuwien.ac.at>
In-Reply-To: <20040910082601.GA32746@gamma.logic.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200409101145.42171.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 September 2004 10:26, Norbert Preining wrote:
> Hi!
>
<snip>
Hi Norbert, Greg,
yesterday we had the same problem so here you go.


> Best wishes
>
> Norbert
>
> ---------------------------------------------------------------------------
>---- Norbert Preining <preining AT logic DOT at>         Technische
> Universität Wien gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76 
> A9C0 D2BF 4AA3 09C5 B094
> ---------------------------------------------------------------------------
>---- YORK (vb.)
> To shift the position of the shoulder straps on a heavy bag or
> rucksack in a vain attempt to make it seem lighter. Hence : to laugh
> falsely and heartily at an unfunny remark. 'Jasmine yorked politely,
> loathing him to the depths of her being' - Virginia Woolf.
>    --- Douglas Adams, The Meaning of Liff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
