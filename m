Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268228AbTALEKs>; Sat, 11 Jan 2003 23:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268227AbTALEKs>; Sat, 11 Jan 2003 23:10:48 -0500
Received: from mail.webmaster.com ([216.152.64.131]:50923 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S268225AbTALEKr> convert rfc822-to-8bit; Sat, 11 Jan 2003 23:10:47 -0500
From: David Schwartz <davids@webmaster.com>
To: <mark@mark.mielke.cc>
CC: Linux kernel list <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Sat, 11 Jan 2003 20:19:32 -0800
In-Reply-To: <20030112033325.GA14644@mark.mielke.cc>
Subject: Re: Nvidia and its choice to read the GPL "differently"
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20030112041934.AAA18620@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jan 2003 22:33:25 -0500, Mark Mielke wrote:

>Why do I doubt the calibre of vxWorks? People I trust who work on RT
>systems
>have told me that in many cases, products with RT requirements can
>perform
>better on Linux, than on vxWorks. (Better meaning managing a higher
>capacity without significant side effects)

	This is an atrocious way to compare a real-time operating system to 
a non-real-time operating system. One would expect that real-time's 
benefits also come at a cost, otherwise all operating systems would 
be real-time operating systems.

	Perhaps Linux can handle more web clients than vxWorks, but can 
Linux guarantee that if the temperature in the core coolant exceeds 
350 degrees, the secondary pump circuit will be activated within 13 
milliseconds?

	A cheap hammer can drive in more nails than a top of the line 
screwdriver.

	DS


