Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbRFBWiK>; Sat, 2 Jun 2001 18:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261968AbRFBWhu>; Sat, 2 Jun 2001 18:37:50 -0400
Received: from zeus.kernel.org ([209.10.41.242]:52166 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261950AbRFBWht>;
	Sat, 2 Jun 2001 18:37:49 -0400
Date: Sat, 2 Jun 2001 15:37:03 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Tim Hockin <thockin@sun.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: Re: [PATCH] HPT370 misc (for real this time)
In-Reply-To: <3B16F12A.61ABCF06@sun.com>
Message-ID: <Pine.LNX.4.10.10106021536240.10960-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


+               p += sprintf(p, "\nController: %d\n", i);
+               p += sprintf(p, "Chipset: HPT%s\n", chipset_nums[class_rev]);
+               p += sprintf(p, "Bus speed: %d MHz\n", dev->bus->bus_speed);
                                                       ^^^^^^^^^^^^^^^^^^^

DNE -- Does Not Exist

+               p += sprintf(p, "--------------- Primary Channel "
+                               "--------------- Secondary Channel "
+                               "--------------\n");
+


Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

