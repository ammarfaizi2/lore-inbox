Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129211AbRBNVMh>; Wed, 14 Feb 2001 16:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129510AbRBNVM2>; Wed, 14 Feb 2001 16:12:28 -0500
Received: from [64.160.188.242] ([64.160.188.242]:59921 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S129318AbRBNVMQ>; Wed, 14 Feb 2001 16:12:16 -0500
Date: Wed, 14 Feb 2001 13:12:14 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: <linux-kernel@vger.kernel.org>
Subject: MP-Table mappings
Message-ID: <Pine.LNX.4.30.0102141309420.5538-100000@ns-01.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In my dmesg I'm getting duplicate table reservations.

found SMP MP-table at 000f5770
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 262128
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32752 pages.
Intel MultiProcessor Specification v1.4
	Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000



Is this an issue?


David


