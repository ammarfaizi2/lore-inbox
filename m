Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbVIXJ6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbVIXJ6T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 05:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVIXJ5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 05:57:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31678 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751456AbVIXJ5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 05:57:51 -0400
Date: Fri, 23 Sep 2005 18:32:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Suspend to RAM broken with 2.6.13
Message-ID: <20050923163200.GC8946@openzaurus.ucw.cz>
References: <1127347633.25357.49.camel@idefix.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127347633.25357.49.camel@idefix.homelinux.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm experiencing problems with suspend to RAM on my Dell D600 laptop.
> When I run Ubuntu's 2.6.10 kernel I have no problem with suspend to RAM.
> However, when I run 2.6.13, my laptop sometimes doesn't wake up. It
> seems like the longer my uptime, the more likely the problem is to occur
> (which makes it hard to reproduce sometimes). This happens even with a
> non-preempt kernel.

Check if it works with minimal drivers and non-preemptible kernel...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

