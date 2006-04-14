Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWDNWCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWDNWCz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 18:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWDNWCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 18:02:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50827 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030194AbWDNWCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 18:02:55 -0400
Date: Sat, 15 Apr 2006 00:02:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Christian Heimanns <ch.heimanns@gmx.de>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: Suspend to disk (some PATCH)
Message-ID: <20060414220254.GA20944@atrey.karlin.mff.cuni.cz>
References: <443C0C2D.1020207@gmx.de> <200604112238.07166.rjw@sisk.pl> <443F86EB.8060903@gmx.de> <200604141611.50740.rjw@sisk.pl> <Pine.LNX.4.61.0604142354390.4238@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0604142354390.4238@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> 
> >> pnp: Device 00:08 does not supported activation.
> >> pnp: Device 00:09 does not supported activation.
> 
> Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

ACK, but I guess you need to add an changelog and mail it to akpm.
								Pavel

-- 
Thanks, Sharp!
