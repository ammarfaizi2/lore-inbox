Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262784AbSKCUQX>; Sun, 3 Nov 2002 15:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262810AbSKCUQW>; Sun, 3 Nov 2002 15:16:22 -0500
Received: from holomorphy.com ([66.224.33.161]:25744 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262784AbSKCUQT>;
	Sun, 3 Nov 2002 15:16:19 -0500
Date: Sun, 3 Nov 2002 12:21:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Patrick Mau <mau@oscar.prima.de>
Cc: Margit Schubert-While <margit@margit.com>, linux-kernel@vger.kernel.org
Subject: Re: U160 on Adaptec 39160
Message-ID: <20021103202130.GX16347@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Patrick Mau <mau@oscar.prima.de>,
	Margit Schubert-While <margit@margit.com>,
	linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021103124403.00b4c860@mail.dns-host.com> <20021103133014.GJ23425@holomorphy.com> <20021103195325.GA9689@oscar.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103195325.GA9689@oscar.homelinux.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 08:53:25PM +0100, Patrick Mau wrote:
> the Adaptec 39160 is indeed capable of doing 160MB/s/channel. Did I
> misread the whole thread ? Here's the dmesg output of my system.
> I get >40MB/s per disk and >80MB/s per channel.
> Maybe it's because of your DVD and DAT device. I only have disks
> connected to the adapter.

DOH

They're both doing SCSI-2, so they'll have to be pulled.

... apparently it's -supposed- to be able to do 160MB/s even on 32-bit
PCI, NFI why mine isn't. It's still really smooth though. I never
missed the speed at all.


Bill
