Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSFEJ2f>; Wed, 5 Jun 2002 05:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSFEJ2e>; Wed, 5 Jun 2002 05:28:34 -0400
Received: from [62.70.58.70] ([62.70.58.70]:5456 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S314096AbSFEJ2e> convert rfc822-to-8bit;
	Wed, 5 Jun 2002 05:28:34 -0400
Message-Id: <200206050928.g559SJ414422@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: Pavel Machek <pavel@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: RAID-6 support in kernel?
Date: Wed, 5 Jun 2002 11:28:19 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Derek Vadala <derek@cynicism.com>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, Tedd Hansen <tedd@konge.net>,
        Christian Vik <christian@konge.net>,
        Lars Christian Nygaard <lars@snart.com>
In-Reply-To: <Pine.LNX.4.33.0206031020290.30424-100000@mail.pronto.tv> <20020603113128.C13204@ucw.cz> <20020604154904.J36@toy.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> RAID-1 over two RAID-5s should withstand any three failures, AFAICS.
>
> You could do RAID-5 over RAID-5. That should survive any 2 failures and
> still be reasonably efficient.

Sure, but still: Is there a good reason why RAID-6 shouldn't be implemented 
in linux?

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.
