Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130127AbQJ0Rsi>; Fri, 27 Oct 2000 13:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129619AbQJ0Rs1>; Fri, 27 Oct 2000 13:48:27 -0400
Received: from mail.aslab.com ([205.219.89.194]:50958 "EHLO mail.aslab.com")
	by vger.kernel.org with ESMTP id <S129359AbQJ0RsS>;
	Fri, 27 Oct 2000 13:48:18 -0400
Message-ID: <017b01c0403d$0c9f19b0$7818b7c0@aslab.com>
From: "Jeff Nguyen" <jeff@aslab.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Ville Herva" <vherva@mail.niksula.cs.hut.fi>,
        <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
In-Reply-To: <E13pD7X-0004fZ-00@the-village.bc.nu>
Subject: Re: VM-global-2.2.18pre17-7
Date: Fri, 27 Oct 2000 10:40:51 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

I agree with your point. In term of usability, the e100 driver has a wider
range of support for the Intel NIC cards.

Jeff

----- Original Message -----
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Nguyen <jeff@aslab.com>
Cc: Ville Herva <vherva@mail.niksula.cs.hut.fi>;
<linux-kernel@vger.kernel.org>; <linux-net@vger.kernel.org>
Sent: Friday, October 27, 2000 10:16 AM
Subject: Re: VM-global-2.2.18pre17-7


> > You should use the Intel e100 driver at
> > http://support.intel.com/support/network/adapter/pro100/100Linux.htm.
> > It works much better than eepro100.
>
> Thats not the general consensus, but its worth trying in case it works
best
> for a given problem. In paticular it knows about bugs with combinations of
> transceivers which the eepro100 driver does not.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
