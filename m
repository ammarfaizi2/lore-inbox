Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270169AbRHGJv3>; Tue, 7 Aug 2001 05:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270171AbRHGJvT>; Tue, 7 Aug 2001 05:51:19 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:31504 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S270169AbRHGJvH>; Tue, 7 Aug 2001 05:51:07 -0400
Message-ID: <20010805220815.A3652@bug.ucw.cz>
Date: Sun, 5 Aug 2001 22:08:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: david@whizziwig.com, linux-kernel@vger.kernel.org, apmd-list@nit.ca
Subject: Re: APM on Acer Travelmate 350te
In-Reply-To: <20010804114813.A21252@zaphod.whizziwig.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010804114813.A21252@zaphod.whizziwig.com>; from David Blackman on Sat, Aug 04, 2001 at 11:48:13AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> 
> 	I have an acer travelmate 350te laptop, everything works
> underlinux except the modem (duh) and power managment. With APM, apm
> --suspend works, but the laptop never wakes up, and just shows the last
> contents of the vga buffer, acpi in prior kernel versions (2.4.2 ->
> 2.4.5) would have a /proc/power, so I could get battery info by hand,
> but no suspend, 2.4.7 has no /proc/power, or /proc/sys/acpi at all. 

2.4.7 has /proc/acpi, check that.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
