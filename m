Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263835AbTHVSYa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 14:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263842AbTHVSYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 14:24:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43937 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263835AbTHVSY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 14:24:28 -0400
Date: Tue, 12 Aug 2003 14:54:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI is shutting down my laptop spontaneously
Message-ID: <20030812125451.GA9755@openzaurus.ucw.cz>
References: <20030807221711.GO2712@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807221711.GO2712@vitelus.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> ...Until I upgraded to 2.6.0-test2 and enabled ACPI. At the point
> where the CPU speed would have been scaled down before, the laptop
> simply halts, giving no warning except announcing it to every
> terminal. I don't like the way my laptop 
What is exact message? Check /proc/acpi/thermal*...

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

