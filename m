Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267819AbTAHSMg>; Wed, 8 Jan 2003 13:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267822AbTAHSMg>; Wed, 8 Jan 2003 13:12:36 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:24193 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267819AbTAHSMf>; Wed, 8 Jan 2003 13:12:35 -0500
Date: Wed, 8 Jan 2003 19:21:12 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Michael Madore <mmadore@aslab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20 IDE for 2.4.21-pre3
Message-ID: <20030108182112.GQ823@louise.pinerecords.com>
References: <3E1C5EF7.8090004@aslab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1C5EF7.8090004@aslab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [mmadore@aslab.com]
> 
> I get the following oops when running 2.4.21-pre3 + 
> 2.4.21-pre3-2420ide-1.  The oops occurred after running the Cerberus 
> stress test for about 5 hours.  The machine uses an ASUS A7N8X single 
> AMD Athlon XP motherboard with the Nvidia nforce2 chipset.  I had to 
> pass ide0=ata66 ide1=ata66 to the kernel in order to use DMA.

Michael,

are you able to reproduce this oops with vanilla 2.4.20?

-- 
Tomas Szepe <szepe@pinerecords.com>
