Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311948AbSCQHpP>; Sun, 17 Mar 2002 02:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311950AbSCQHpF>; Sun, 17 Mar 2002 02:45:05 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:9144 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311948AbSCQHop>; Sun, 17 Mar 2002 02:44:45 -0500
Date: Sun, 17 Mar 2002 09:27:52 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH] Natsemi Geode GXn PM support and extended MMX
In-Reply-To: <E16mHsN-0006jT-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0203170926300.6387-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2002, Alan Cox wrote:

> Be very careful playing with Cyrix/Geode stuff. In the APM case the BIOS 
> is doing the right thing on every box I have ever seen. The extended MMX
> one looks right, providing we don't turn it on for any CPU lacking it

Hmm thanks for the warning, i wonder if the BIOS enables most of the APM 
features of the CPU as well.

	Zwane


