Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268900AbRHFRMj>; Mon, 6 Aug 2001 13:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268903AbRHFRMU>; Mon, 6 Aug 2001 13:12:20 -0400
Received: from hypnos.cps.intel.com ([192.198.165.17]:42987 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S268900AbRHFRMF>; Mon, 6 Aug 2001 13:12:05 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDE01F@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'david@whizziwig.com'" <david@whizziwig.com>,
        linux-kernel@vger.kernel.org, apmd-list@nit.ca
Subject: RE: APM on Acer Travelmate 350te
Date: Mon, 6 Aug 2001 10:04:04 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David Blackman [mailto:david@whizziwig.com]
> 	I have an acer travelmate 350te laptop, everything works
> underlinux except the modem (duh) and power managment. With APM, apm
> --suspend works, but the laptop never wakes up, and just 
> shows the last
> contents of the vga buffer, acpi in prior kernel versions (2.4.2 ->
> 2.4.5) would have a /proc/power, so I could get battery info by hand,
> but no suspend, 2.4.7 has no /proc/power, or /proc/sys/acpi at all. 

While not directly related to your APM problem...

ACPI data is under /proc/acpi at the moment - I hope this is helpful, but
until we implement sleep I'd recommend keep trying to get APM working.

Regards -- Andy

