Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130515AbRAaBqn>; Tue, 30 Jan 2001 20:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131230AbRAaBqd>; Tue, 30 Jan 2001 20:46:33 -0500
Received: from dns2.chaven.com ([207.238.162.18]:27298 "EHLO shell.chaven.com")
	by vger.kernel.org with ESMTP id <S130515AbRAaBqW>;
	Tue, 30 Jan 2001 20:46:22 -0500
Message-ID: <033c01c08b27$5944a430$160912ac@stcostlnds2zxj>
From: "List User" <lists@chaven.com>
To: "Timur Tabi" <ttabi@interactivesi.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <FLRPM.A.TsC.j41d6@dinero.interactivesi.com>
Subject: Re: Request: increase in PCI bus limit
Date: Tue, 30 Jan 2001 19:44:23 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

He's probably sending it to the list the same reason why most in tech
circles do.
To cut down on the amount of work required.  Personally I would love to have
all my custom changes put into a 'standard' distribution that way I wouldn't
need
to keep as many custom notes for x,y,z platforms or what-else.  Also for the
fact that it gives something back (generally if I run into a situation there
is a good
chance that someone else will run into it as well, so if I can make _his_
life
easier if he doesn't have the same knowledge it's worth it).

Steve
----- Original Message -----
From: "Timur Tabi" <ttabi@interactivesi.com>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, January 30, 2001 18:36
Subject: Re: Request: increase in PCI bus limit


> ** Reply to message from Christopher Neufeld <neufeld@linuxcare.com> on
Tue, 30
> Jan 2001 16:08:32 -0800
>
>
> > Would it be possible to bump it up to 128, or even
> > 256, in later 2.4.* kernel releases?  That would allow this customer to
> > work with an unpatched kernel, at the cost of an additional 3.5 kB of
> > variables in the kernel.
>
> I don't think that's going to happen.  If we did this for your obscure
system,
> then we'd have to do it for every obscure system, and before you know it,
the
> kernel is 200KB larger.
>
> Besides, why is your client afraid of patched kernels?  It sounds like a
very
> odd request from someone with a linuxcare.com email address.  I would
think that
> you'd WANT to provide patched kernels so that the customer can keep paying
you
> (until they learn how to use a text editor, at which point they can patch
the
> kernel themselves!!!)
>
>
> --
> Timur Tabi - ttabi@interactivesi.com
> Interactive Silicon - http://www.interactivesi.com
>
> When replying to a mailing-list message, please direct the reply to the
mailing list only.  Don't send another copy to me.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
