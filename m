Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbSLZEkf>; Wed, 25 Dec 2002 23:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSLZEkf>; Wed, 25 Dec 2002 23:40:35 -0500
Received: from mail.econolodgetulsa.com ([198.78.66.163]:27653 "EHLO
	mail.econolodgetulsa.com") by vger.kernel.org with ESMTP
	id <S261398AbSLZEke>; Wed, 25 Dec 2002 23:40:34 -0500
Date: Wed, 25 Dec 2002 20:48:43 -0800 (PST)
From: Josh Brooks <user@mail.econolodgetulsa.com>
To: Billy Rose <billyrose@billyrose.net>
cc: bp@dynastytech.com, <linux-kernel@vger.kernel.org>,
       <felipewd@terra.com.br>
Subject: Re: CPU failures ... or something else ?
In-Reply-To: <E18RPWN-0001xf-00@host.ehost4u.biz>
Message-ID: <20021225204808.O28396-100000@mail.econolodgetulsa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are you saying that you think bank 4 is bad because you saw this in my
error:

localhost kernel: Bank 4: b200000000040151
                  ^^^^^^

(just asking to increase my own understanding)

thanks!



On Wed, 25 Dec 2002, Billy Rose wrote:

> > Understood.  Thank you for that diagnosis.
> >
> >
> > usually it says proc #1 in the error, but the first time it said proc
> > #0 - is that interesting ?
>
> youre welcome :)
>
> if youre hanging on to that box, remove the memory from banks 3 and 4
> and it should be ok. if my memory serves me right, you cant have only 3
> banks of memory (hence removing bank 3 also), the motherboard is
> configured to handle 1, 2, or 4 populated banks. it you leave bank 3
> in while removing bank 4, it will beep at you when you power it on and
> do nothing. with a gig of ram, it should still be plenty useful.
>
> billy
> =====
> "there's some milk in the fridge that's about to go bad...
> and there it goes..." -bobby
>

