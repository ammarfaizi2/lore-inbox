Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282845AbSAMJ63>; Sun, 13 Jan 2002 04:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282902AbSAMJ6T>; Sun, 13 Jan 2002 04:58:19 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:8346 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S282845AbSAMJ6G>; Sun, 13 Jan 2002 04:58:06 -0500
Date: Sun, 13 Jan 2002 11:57:25 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <wfilardo@fuse.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 Unable to boot on Cyrix box? 
Message-ID: <Pine.LNX.4.33.0201131154460.28980-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try compiling a kernel _without_ SIS5513 IDE support and with use DMA by
default disabled and see wether it stops at the same point.

Regards,
	Zwane Mwaikambo


