Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268001AbTBMKwu>; Thu, 13 Feb 2003 05:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268018AbTBMKwu>; Thu, 13 Feb 2003 05:52:50 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:38533 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S268001AbTBMKwt>; Thu, 13 Feb 2003 05:52:49 -0500
Date: Thu, 13 Feb 2003 06:02:38 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.60 - BUG() in usb-storage
Message-ID: <20030213110238.GA1184@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030213090029.GA2304@Master.Wizards>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030213090029.GA2304@Master.Wizards>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 04:00:29AM -0500, Murray J. Root wrote:
> ASUS P4S533 (SiS645DX)
> SanDisk SDDR-77 ImageMate
> 
> Feb 13 03:44:56 Master kernel: ------------[ cut here ]------------
> Feb 13 03:44:56 Master kernel: kernel BUG at drivers/usb/storage/usb.c:981!
.....
> SanDisk light blinked a bit as if it were writing to the card. Haven't rebooted yet to
> clear the device and see if anything was actually written.
> 

The data was written to the card correctly.

Note: mounting takes an incredibly long time - about 30 seconds. Monitors show
no activity during this time - it's as if it's just waiting for a timeout.

-- 
Murray J. Root

