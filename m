Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132643AbRDXBGg>; Mon, 23 Apr 2001 21:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132655AbRDXBG0>; Mon, 23 Apr 2001 21:06:26 -0400
Received: from adsl-64-123-58-70.dsl.stlsmo.swbell.net ([64.123.58.70]:58621
	"EHLO bigandy.swbell.net") by vger.kernel.org with ESMTP
	id <S132643AbRDXBGR>; Mon, 23 Apr 2001 21:06:17 -0400
Date: Mon, 23 Apr 2001 20:06:11 -0500 (CDT)
From: Andy Carlson <naclos@swbell.net>
To: linux-kernel@vger.kernel.org
Subject: Matrox FB console driver
Message-ID: <Pine.LNX.4.20.0104232001580.188-100000@bigandy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was playing around with a program that I was using to time differences
between kernels (a silly prime program that puts out 1000000 primes).  I
noticed a very strange behaviour.  On a fresh boot, with the Penguin
pictures that the Matrox FB driver puts up, the prime program runs
1 minute, 30 seconds.  If I reset, it still runs 1M30S.  If I start X,
and exit, it runs 48 seconds.  Is this a known behaviour?  Thanks.

Andy Carlson                           |\      _,,,---,,_
naclos@swbell.net                ZZZzz /,`.-'`'    -.  ;-;;,_
BJC Health System                     |,4-  ) )-,_. ,\ (  `'-'
St. Louis, Missouri                  '---''(_/--'  `-'\_)
Cat Pics: http://andyc.dyndns.org

