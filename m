Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262873AbRE0Xj2>; Sun, 27 May 2001 19:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262874AbRE0XjT>; Sun, 27 May 2001 19:39:19 -0400
Received: from are.twiddle.net ([64.81.246.98]:18568 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S262873AbRE0XjG>;
	Sun, 27 May 2001 19:39:06 -0400
Date: Sun, 27 May 2001 16:39:01 -0700
From: Richard Henderson <rth@twiddle.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Ingo T. Storm" <it@lapavoni.de>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: 2.4.5 does not link on Ruffian (alpha)
Message-ID: <20010527163901.A18929@twiddle.net>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	"Ingo T. Storm" <it@lapavoni.de>, linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <3B0BFE90.CE148B7@kjist.ac.kr> <20010523210923.A730@athlon.random> <022e01c0e5fc$39ac0cf0$2e2ca8c0@buxtown.de> <3B102822.625E01DF@mandrakesoft.com> <3B1032BE.72BD1336@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B1032BE.72BD1336@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, May 26, 2001 at 06:48:30PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 06:48:30PM -0400, Jeff Garzik wrote:
> When built with CONFIG_ALPHA_NAUTILUS, my UP1000's IDE totally fails. 

Mine doesn't.

> I am booting w/ aboot 0.7a from SRM, -without- the
> srm-as-bootloader kernel config option. 

That is the error.


r~
