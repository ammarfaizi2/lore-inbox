Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRA2WzY>; Mon, 29 Jan 2001 17:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130599AbRA2WzF>; Mon, 29 Jan 2001 17:55:05 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:27659 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129584AbRA2WzA>; Mon, 29 Jan 2001 17:55:00 -0500
Date: Mon, 29 Jan 2001 16:49:53 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: Re: [ANNOUNCE] Dolphin PCI-SCI RPM Drivers 1.1-4 released
Message-ID: <20010129164953.A15219@vger.timpanogas.org>
In-Reply-To: <20010129142723.A14086@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010129142723.A14086@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Mon, Jan 29, 2001 at 02:27:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Relative to some performance questions folks have asked, the SCI 
adapters are limited by PCI bus speeds.  If your system supports 
64-bit PCI you get much higher numbers.  If you have a system 
that supports 100+ Megabyte/second PCI throughput, the SCI 
adapters will exploit it.

This test was performed in on a 32-bit PCI system with a PCI bus
architecture that's limited to 70 MB/S.  

Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
