Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279251AbRJWFjK>; Tue, 23 Oct 2001 01:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279249AbRJWFjA>; Tue, 23 Oct 2001 01:39:00 -0400
Received: from smtp.alacritech.com ([209.10.208.82]:45834 "EHLO
	smtp.alacritech.com") by vger.kernel.org with ESMTP
	id <S279251AbRJWFiq>; Tue, 23 Oct 2001 01:38:46 -0400
Message-ID: <3BD501AF.7B4D7645@alacritech.com>
Date: Mon, 22 Oct 2001 22:35:44 -0700
From: "Matt D. Robinson" <yakker@alacritech.com>
Organization: Alacritech, Inc.
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael H. Warfield" <mhw@wittsend.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
In-Reply-To: <20011022172742.B445@virtucon.warpcore.org> <E15vnuN-0003jW-00@the-village.bc.nu> <20011022203159.A20411@virtucon.warpcore.org> <20011022214324.A18888@alcove.wittsend.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds like Linux is slowly crawling towards the WHQL perspective on
drivers from Microsoft.  If they aren't qualified:

	Microsoft == WHQL
	Linux == ((!tainted) + EXPORT_SYMBOL_GPL() + ...)

... then they aren't supportable or acceptable for distribution by
anyone other than the creators.

I wouldn't be surprised if someone creates a LHQL process or
business to qualify binary drivers on supportable kernels from
distributions.  I'd give it about a year.

--Matt

"Michael H. Warfield" wrote:
>         Really?  Sure as hell hasn't been my experience.  Oh!  That only
> works with Windows 95!  Ok, now you can get the driver to support Windows
> 98 but it won't support Windows NT (got one RIGHT NOW like that).  Oops,
> you upgraded to Windows 2000, can't support that with that driver, we
> don't have a driver for that yet.  Windows XP, sorry, we don't have the
> Windows XP certified driver, yet, try back in a few months.
> 
>         Think that's a joke?  I think it's pathetic and it is EXACTLY
> what I have experienced with multimedia cards, scanners, and printers.
