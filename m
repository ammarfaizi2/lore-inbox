Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317871AbSFNCQN>; Thu, 13 Jun 2002 22:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317872AbSFNCQM>; Thu, 13 Jun 2002 22:16:12 -0400
Received: from cambot.suite224.net ([209.176.64.2]:6149 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S317871AbSFNCQM>;
	Thu, 13 Jun 2002 22:16:12 -0400
Message-ID: <001e01c21349$f5f66060$f7f583d0@pcs686>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <davej@suse.de> <200206140013.g5E0DQR25561@localhost.localdomain> <20020614024547.H16772@suse.de>
Subject: Re: [PATCH: NEW SUBARCHITECTURE FOR 2.5.21] support for NCR voyager (3/4/5xxx series)
Date: Thu, 13 Jun 2002 22:19:49 -0400
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




>  > > Sounds quite logical. What does the current patches you have do ?
I've
>  > > not had chance to look at them yet.
>  > It creates directories `generic' for the standard pc and `visws'.  The
voyager
>  > patch creates a `voyager' directory.  Alternatively, these could be
`mach-pc',
>  > `mach-visws' and `mach-voyager'.
>
> Yeah, I think mach-foo would be more aesthetically pleasing, so I'll
> cast my vote for that one. If nothing else, it makes it obvious that
> the subdir isn't important if you don't care about $subarch
>
I think it would be a good idea as well.

Matthew

