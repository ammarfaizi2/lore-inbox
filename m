Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265590AbUGGWiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265590AbUGGWiH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 18:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbUGGWiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 18:38:07 -0400
Received: from c-24-17-224-197.client.comcast.net ([24.17.224.197]:18682 "EHLO
	mail.agarithil-nost.com") by vger.kernel.org with ESMTP
	id S265590AbUGGWiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 18:38:03 -0400
Date: Wed, 7 Jul 2004 15:37:45 -0700
Subject: Kernel 2.6.7 hangs..
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v553)
From: Robert Horton <trebor@agarithil-nost.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
In-Reply-To: <001801c46470$94116820$0a01a8c0@jwrdesktop>
Message-Id: <44108A2B-D066-11D8-8BAE-0003933EE6DC@agarithil-nost.com>
X-Mailer: Apple Mail (2.553)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have recently completed building a LFS (linux from scratch) system 
which uses the 2.6.7 kernel on a i686 machine. Upon reboot the systems 
hangs after the BIOS RAM mapping. Specifically:

-snip-
511MB LOWMEM available
On node 0 totalpages: 131056
	DMA zone: 4096 pages, LIFO batch: 1
	Normal zone: 126960 pages, LIFO batch: 16
	HighMem zone: 0 pages, LIFO batch: 1


and that is as far as it goes unless it takes an inordinate amount of 
time to continue past that point. I did leave it for approximately four 
minutes and had no further progression.

I searched the archives and while I did not find anything pertaining 
this I did see that the next logical progression deals with DMI and 
ACPI so I do not know if it is hanging at the memory portion or the 
next portion.

Any help would be appreciated.

Cheers,

Rob

