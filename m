Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317389AbSFCOw2>; Mon, 3 Jun 2002 10:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317387AbSFCOw1>; Mon, 3 Jun 2002 10:52:27 -0400
Received: from daimi.au.dk ([130.225.16.1]:4283 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317386AbSFCOwZ>;
	Mon, 3 Jun 2002 10:52:25 -0400
Message-ID: <3CFB82A0.EB2062AE@daimi.au.dk>
Date: Mon, 03 Jun 2002 16:52:16 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Derek Vadala <derek@cynicism.com>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, Tedd Hansen <tedd@konge.net>,
        Christian Vik <christian@konge.net>,
        Lars Christian Nygaard <lars@snart.com>
Subject: Re: RAID-6 support in kernel?
In-Reply-To: <Pine.LNX.4.33.0206031020290.30424-100000@mail.pronto.tv> <Pine.GSO.4.21.0206030213510.23709-100000@gecko.roadtoad.net> <20020603113128.C13204@ucw.cz>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> He was thinking "mirror", not "stripe". Mirror of 2 RAID-5 arrays (would
> be probably called RAID-15 (when there is a RAID-10 for mirrored stripe
> arrays)), can withstand any two disks failing anytime.

It can actually withstand any *three* disks failing anytime.

> Even more for
> certain combinations. But it is terribly inefficient.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
