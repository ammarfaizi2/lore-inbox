Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136035AbREBWdz>; Wed, 2 May 2001 18:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136036AbREBWdf>; Wed, 2 May 2001 18:33:35 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:32155 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S136035AbREBWdX>; Wed, 2 May 2001 18:33:23 -0400
Message-ID: <3AF08AE7.E36EC268@uow.edu.au>
Date: Thu, 03 May 2001 08:32:07 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>
CC: "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [3com905b freeze Alpha SMP 2.4.2] FullDuplex issue ?
In-Reply-To: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CDCA@aeoexc1.aeo.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Cabaniols, Sebastien" wrote:
> 
> [ SMP Alpha dies running TCP Rx+Tx ]
>

Sebastien, I'd be suspecting the 2.4.2/Alpha kernel
more than the ethernet driver.  Are you able to reproduce
this with more recent kernels?

-
