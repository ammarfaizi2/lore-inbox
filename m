Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317491AbSFDMuR>; Tue, 4 Jun 2002 08:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317494AbSFDMuQ>; Tue, 4 Jun 2002 08:50:16 -0400
Received: from [62.70.58.70] ([62.70.58.70]:6122 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317491AbSFDMuN> convert rfc822-to-8bit;
	Tue, 4 Jun 2002 08:50:13 -0400
Message-Id: <200206041249.g54CntV07616@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: Kasper Dupont <kasperd@daimi.au.dk>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: RAID-6 support in kernel?
Date: Tue, 4 Jun 2002 14:49:54 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Derek Vadala <derek@cynicism.com>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, Tedd Hansen <tedd@konge.net>,
        Christian Vik <christian@konge.net>,
        Lars Christian Nygaard <lars@snart.com>
In-Reply-To: <Pine.LNX.4.33.0206031020290.30424-100000@mail.pronto.tv> <20020603113128.C13204@ucw.cz> <3CFB82A0.EB2062AE@daimi.au.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 June 2002 16:52, Kasper Dupont wrote:
> Vojtech Pavlik wrote:
> > He was thinking "mirror", not "stripe". Mirror of 2 RAID-5 arrays (would
> > be probably called RAID-15 (when there is a RAID-10 for mirrored stripe
> > arrays)), can withstand any two disks failing anytime.
>
> It can actually withstand any *three* disks failing anytime.

still - I don't want to waste that money

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.
