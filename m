Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286708AbRLVHxD>; Sat, 22 Dec 2001 02:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286709AbRLVHwx>; Sat, 22 Dec 2001 02:52:53 -0500
Received: from swm.pp.se ([195.54.133.5]:36300 "EHLO uplift.swm.pp.se")
	by vger.kernel.org with ESMTP id <S286708AbRLVHwq>;
	Sat, 22 Dec 2001 02:52:46 -0500
Date: Sat, 22 Dec 2001 08:52:42 +0100 (CET)
From: Mikael Abrahamsson <swmike@swm.pp.se>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.hel
 p.
In-Reply-To: <200112202303.fBKN3qY25517@irishsea.home.craig-wood.com>
Message-ID: <Pine.LNX.4.33.0112220850330.8631-100000@uplift.swm.pp.se>
Organization: People's Front Against WWW
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2001 ncw@axis.demon.co.uk wrote:

> Actually a 1 Mb/s connection is 1024000 bits/second (ie not 1000000 or
> 1048576 bits/second).

But gigabit ethernet is clocked at 1.25GHz with 8b10-encoding, meaning 
you'll get literally 1.000.000.000 bits/second over that line. As far as I 
know this is true for all kinds of ethernet.
 
Basically, it's only when it comes to memory terms that we use 1024 as a 
base.

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se

