Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288870AbSAXSdH>; Thu, 24 Jan 2002 13:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288862AbSAXScr>; Thu, 24 Jan 2002 13:32:47 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:39685 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288859AbSAXScn>;
	Thu, 24 Jan 2002 13:32:43 -0500
Date: Thu, 24 Jan 2002 16:33:10 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
Message-ID: <20020124183310.GD27763@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linux-Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3C5047A2.1AB65595@mandrakesoft.com> <5.1.0.14.2.20020124181848.00b23180@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020124181848.00b23180@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 24, 2002 at 06:22:03PM +0000, Anton Altaparmakov escreveu:
> At 17:42 24/01/02, Jeff Garzik wrote:
> >Actually I prefer 'bool' to '_Bool', if this becomes a kernel standard.
> 
> I would be in favour of this as it does make code more readable. I use it 
> in ntfs tng quite a bit (but I just typedef a BOOL type myself).
> 
> If it is added, then _please_ don't use '_Bool', that's just sick... 
> 'bool', heck even 'BOOL' would be better than that!

I'd vote for bool, long are the days when I programmed COBOL in original
3270 terminals, heck it seems like it was in a previous life 8)

/me scratches head, I should go back and update the kernel janitor TODO
list with this...

- Arnaldo
