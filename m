Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLFQKk>; Wed, 6 Dec 2000 11:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLFQK3>; Wed, 6 Dec 2000 11:10:29 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:504 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129183AbQLFQKN>; Wed, 6 Dec 2000 11:10:13 -0500
Date: Wed, 6 Dec 2000 10:39:42 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Tom Murphy <freyason@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE fs corruption in 2.4.0-test11?
In-Reply-To: <20001206151250.25734.qmail@web2007.mail.yahoo.com>
Message-ID: <Pine.LNX.4.30.0012061036180.19876-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using these options just fine with my Maxtor and IBM drives. What
IDE controller do you have?

On Wed, 6 Dec 2000, Tom Murphy wrote:
> Which options in hdparm are considered dangerous to use in 2.4?
> I had 32-bit I/O set (-c 1) , DMA set on (-d 1), multiple sector I/O
> (-m 16). The drive in question is a 45 gigabyte Western Digital Caviar
> drive.
>
> I heard the multiple sector I/O may be bad for the drives.. is this
> true?
>

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
