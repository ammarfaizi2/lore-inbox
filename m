Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268177AbTAKXvE>; Sat, 11 Jan 2003 18:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268178AbTAKXvE>; Sat, 11 Jan 2003 18:51:04 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:17287 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268177AbTAKXvD>;
	Sat, 11 Jan 2003 18:51:03 -0500
Date: Sat, 11 Jan 2003 23:57:37 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.56
Message-ID: <20030111235737.GB25493@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Adrian Bunk <bunk@fs.tum.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301101222510.1856-100000@penguin.transmeta.com> <20030111094345.GI10486@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030111094345.GI10486@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 10:43:45AM +0100, Adrian Bunk wrote:

 > drivers/char/watchdog/sc1200wdt.c doesn't compile:

Yup, it didn't before I poked it too, it needs updating to the new PNP-fu

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
