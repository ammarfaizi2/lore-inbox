Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265350AbRF2AiJ>; Thu, 28 Jun 2001 20:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265354AbRF2Ah6>; Thu, 28 Jun 2001 20:37:58 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:28947 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265350AbRF2Ahz>;
	Thu, 28 Jun 2001 20:37:55 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: ankry@green.mif.pg.gda.pl, elenstev@mesatop.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.6-pre6 fix drivers/net/Config.in error 
In-Reply-To: Your message of "Thu, 28 Jun 2001 16:40:51 -0400."
             <3B3B9653.A8331780@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Jun 2001 10:37:48 +1000
Message-ID: <11982.993775068@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001 16:40:51 -0400, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>Keith Owens wrote:
>> True, but the line is a cut and paste from higher up in
>> drivers/net/Config.in.  Even though it is redundant, it is consistent
>> with the rest of the file.
>
>It is not redundant because in theory CONFIG_EISA could exist without
>CONFIG_ISA.

Really?  I checked all the arch config.in files in the kernel and none
allow EISA without ISA first.

