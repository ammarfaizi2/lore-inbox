Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280047AbRKNDRT>; Tue, 13 Nov 2001 22:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280043AbRKNDRN>; Tue, 13 Nov 2001 22:17:13 -0500
Received: from pizda.ninka.net ([216.101.162.242]:57229 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280056AbRKNDQS>;
	Tue, 13 Nov 2001 22:16:18 -0500
Date: Tue, 13 Nov 2001 19:16:07 -0800 (PST)
Message-Id: <20011113.191607.00304518.davem@redhat.com>
To: goemon@anime.net
Cc: hiryuu@envisiongames.net, calin@ajvar.org, nitrax@giron.wox.org,
        linux-kernel@vger.kernel.org
Subject: Re: What Athlon chipset is most stable in Linux?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0111131910440.9658-100000@anime.net>
In-Reply-To: <20011113.183256.15406047.davem@redhat.com>
	<Pine.LNX.4.30.0111131910440.9658-100000@anime.net>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dan Hollis <goemon@anime.net>
   Date: Tue, 13 Nov 2001 19:11:56 -0800 (PST)

   BTW this bug apparently doesnt affect AMD760MP as I am able to use
   geforce2 with quake and unreal tournament for hours straight without any
   problems.

What is your quake3 com_maxfps set to?  By default it is 85, and
that can hide the bug.  Set it to 130 or something like that.

Just bring down the quake3 console (with ') and type

/com_maxfps 130

Try that for a while.

I'm rather sure the AMD761 problems are motherboard vendor
independant, because I have 2 systems so far, using totally different
AMD761 based motherboards, which both hang pretty reliably with AGP.

Franks a lot,
David S. Miller
davem@redhat.com

