Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129495AbRBVVID>; Thu, 22 Feb 2001 16:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130229AbRBVVHx>; Thu, 22 Feb 2001 16:07:53 -0500
Received: from saw.swusa.com ([207.214.125.61]:53648 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S129495AbRBVVHn>;
	Thu, 22 Feb 2001 16:07:43 -0500
Message-ID: <20010222130813.A7770@saw.sw.com.sg>
Date: Thu, 22 Feb 2001 13:08:13 -0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Ionut Dumitrache <Ionut.Dumitrache@imar.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i82562ET LAN (i815) timeout/lockup with eepro100 driver
In-Reply-To: <20010219203207.1500015381@pompeiu.imar.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010219203207.1500015381@pompeiu.imar.ro>; from "Ionut Dumitrache" on Mon, Feb 19, 2001 at 08:32:07PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If it's a VALinux computer, contact them.
They've made some progress in tracking different eepro100 problems.

	Andrey

On Mon, Feb 19, 2001 at 08:32:07PM +0200, Ionut Dumitrache wrote:
>         The integrated LAN on Intel boards with i815 chipset 
> apparently is not fully supported. In latest 2.2.x and 2.4.x,
> with the EtherExpress Pro100 driver, after some network traffic,
> it locks. The only way I can use the net again is either reboot,
> or ifconfig eth0 down; ifconfig eth0 up. 
>    I attached the syslog output;
> 
> The driver detects the chip as 82562EM although the mainboard
> manual states that it has an integrated i82562ET chip.
> 
> Board: Intel D815EEA with onboard LAN, video,audio
> 
[snip]
> eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com>
> 2000/11/15
