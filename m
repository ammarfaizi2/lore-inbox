Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSFEJgx>; Wed, 5 Jun 2002 05:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSFEJgw>; Wed, 5 Jun 2002 05:36:52 -0400
Received: from [62.70.58.70] ([62.70.58.70]:11600 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S314082AbSFEJgv> convert rfc822-to-8bit;
	Wed, 5 Jun 2002 05:36:51 -0400
Message-Id: <200206050936.g559abS14499@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: Kasper Dupont <kasperd@daimi.au.dk>, Pavel Machek <pavel@suse.cz>
Subject: Re: RAID-6 support in kernel?
Date: Wed, 5 Jun 2002 11:36:37 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Vojtech Pavlik <vojtech@suse.cz>, Derek Vadala <derek@cynicism.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Tedd Hansen <tedd@konge.net>, Christian Vik <christian@konge.net>,
        Lars Christian Nygaard <lars@snart.com>
In-Reply-To: <Pine.LNX.4.33.0206031020290.30424-100000@mail.pronto.tv> <20020604154904.J36@toy.ucw.cz> <3CFD3EE5.DAE3E2C9@daimi.au.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> RAID-4 on top of RAID-4 is actually just a two-dimentional
> parity. RAID-5 on top of RAID-5 is very similar.

er. RAID-4 is as RAID-5, but with dedicated parity disk.
RAID-6 is with two-dimentional parity

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.
