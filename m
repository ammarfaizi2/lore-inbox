Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282400AbRKXIHm>; Sat, 24 Nov 2001 03:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282401AbRKXIHc>; Sat, 24 Nov 2001 03:07:32 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:8080 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S282400AbRKXIH0>; Sat, 24 Nov 2001 03:07:26 -0500
From: Mikael Gustaf Claesson <mgcl851@cse.unsw.EDU.AU>
To: linux-kernel@vger.kernel.org
Date: Sat, 24 Nov 2001 19:07:23 +1100 (EST)
Subject: USB CD-RW funny with newer kernels
Message-ID: <Pine.GSO.4.21.0111241901200.4734-100000@hummel.orchestra.cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I have an external USB CD-RW from Sony connected to my Toshiba
notebook. It works fine up until kernel 2.4.10, but with 2.4.12 through
2.4.15 the data throughput is so slow that the burning fails every time. I
use gtoaster, which in turn uses cdrecord. I have configured the kernels
exactly the same every time.

If I should submit an official bug report somewhere, could someone please
tell me how? If this is a known bug, does anyone know how I can solve
my problem? For now I'll just run 2.4.10, but I might want to upgrade in
the future.

Thanks...

/M

