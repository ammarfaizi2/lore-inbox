Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278985AbRKFK6u>; Tue, 6 Nov 2001 05:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278968AbRKFK6m>; Tue, 6 Nov 2001 05:58:42 -0500
Received: from web13106.mail.yahoo.com ([216.136.174.151]:40903 "HELO
	web13106.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S278961AbRKFK6b>; Tue, 6 Nov 2001 05:58:31 -0500
Message-ID: <20011106105830.85031.qmail@web13106.mail.yahoo.com>
Date: Tue, 6 Nov 2001 02:58:30 -0800 (PST)
From: szonyi calin <caszonyi@yahoo.com>
Subject: Re: Limited RAM - how to save it?
To: Matt Bernstein <matt@theBachChoir.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111051259400.28836-100000@nick.dcs.qmul.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Matt Bernstein <matt@theBachChoir.org.uk> wrote:
> You might like to patch an older Linux than 2.2 :)
> dietlibc might help userspace, too.. (though I don't
> know if you can link
> against it)

Kernel 2.4 is better at speed than 2.2. (and at mm)

> 
> At 12:52 +0100 Jan-Benedict Glaw wrote:
> 
> >I'm working on a 4MB linux system (for a customer)
> which has quite
> >limited resources at all:
> >
> >	- 4MB RAM
> >	- 386 or 486 like processor (9..16 BogoMIPS)
> >	- < 100MB HDD
> >	- Quite a lot user space running:-(
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________
Do You Yahoo!?
Find a job, post your resume.
http://careers.yahoo.com
