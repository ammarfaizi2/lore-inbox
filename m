Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317003AbSFBAej>; Sat, 1 Jun 2002 20:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSFBAei>; Sat, 1 Jun 2002 20:34:38 -0400
Received: from web10401.mail.yahoo.com ([216.136.130.93]:56195 "HELO
	web10401.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317003AbSFBAei>; Sat, 1 Jun 2002 20:34:38 -0400
Message-ID: <20020602003438.73728.qmail@web10401.mail.yahoo.com>
Date: Sun, 2 Jun 2002 10:34:38 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: 2.4.19-pre9-ac3 still OOPS when exiting X with i810 chipset
To: Andris Pavenis <pavenis@lanet.lv>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CF8EDEF.3070708@lanet.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Same hardware as I'm using, but I haven't seen any
> OOPSes

Do you enable DRI?  I dont have oopes if I disable DRI
inXFree86 config file,
I use XFree86-4.1.0 from Mandrake 8.1; compile using
its gcc; and usually having no trouble with this so
far


May be I should upgrade to XFree86-4.2.0 but as far as
I know the dri module in the standard kernel is too
old for 4.2.0 to enable dri....


=====
Steve Kieu

http://www.sold.com.au - The Sold.com.au Big Brand Sale
- New PCs, notebooks, digital cameras, phones and more ... Sale ends June 12
