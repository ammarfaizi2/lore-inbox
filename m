Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267509AbTBLPuN>; Wed, 12 Feb 2003 10:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267387AbTBLPuM>; Wed, 12 Feb 2003 10:50:12 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:43150 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267509AbTBLPtc>;
	Wed, 12 Feb 2003 10:49:32 -0500
Date: Wed, 12 Feb 2003 15:55:06 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Adam Belay <ambx1@neo.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.20][2.5.60] /proc/interrupts comparsion - two irqs for i8042?
Message-ID: <20030212155506.GA13038@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Shawn Starr <spstarr@sh0n.net>, Adam Belay <ambx1@neo.rr.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302121035420.147-100000@coredump.sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302121035420.147-100000@coredump.sh0n.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 10:36:16AM -0500, Shawn Starr wrote:

 >   1:         15          XT-PIC  i8042

keyboard.
 
 >  12:         60          XT-PIC  i8042 <--???

PS2 mouse.
 
		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
