Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267143AbRGJVEY>; Tue, 10 Jul 2001 17:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267145AbRGJVEP>; Tue, 10 Jul 2001 17:04:15 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9183 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S267143AbRGJVDz>;
	Tue, 10 Jul 2001 17:03:55 -0400
Message-ID: <3B4B6DB8.F26663A1@mandrakesoft.com>
Date: Tue, 10 Jul 2001 17:03:52 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: daniel sheltraw <l5gibson@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CardBus and PCI
In-Reply-To: <F34guA8M6XQQez1enAq000153a1@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

daniel sheltraw wrote:
> 
> Hello kernel list
> 
> If a CardBus card is in a slot at boot time is it treated as PCI device
> would be? Is it just another device on another PCI bus?

In kernel 2.4 and using kernel cardbus support, yes.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
