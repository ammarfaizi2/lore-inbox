Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265583AbUBBDM3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 22:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265590AbUBBDM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 22:12:29 -0500
Received: from champagne.comp.nus.edu.sg ([137.132.80.90]:21253 "EHLO
	champagne.comp.nus.edu.sg") by vger.kernel.org with ESMTP
	id S265583AbUBBDM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 22:12:28 -0500
Date: Mon, 2 Feb 2004 11:14:00 +0800 (SGT)
From: Lai Zit Seng <lzs@comp.nus.edu.sg>
X-X-Sender: lzs@localhost.localdomain
To: Warren Togami <wtogami@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Trouble with Cisco Airo MPI350 and kernel-2.6.1+
In-Reply-To: <401D6FD8.2040406@redhat.com>
Message-ID: <Pine.LNX.4.44.0402021106000.23974-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Feb 2004, Warren Togami wrote:

> Are these many errors normal?
> 
> [root@ibmlaptop etc]# iwconfig eth1
> Warning: Driver for device eth1 has been compiled with version 16
> of Wireless Extension, while this program is using version 15.
> Some things may be broken...
> 
> eth1      IEEE 802.11-DS  ESSID:"apophis"  Nickname:"ibmlaptop"
>            Mode:Managed  Frequency:2.412GHz  Access Point: 00:0C:41:75:D4:02
>            Bit Rate:11Mb/s   Tx-Power=20 dBm   Sensitivity=0/0
>            Retry limit:16   RTS thr:off   Fragment thr:off
>            Encryption key:****-****-**   Security mode:open
>            Power Management:off
>            Link Quality:30/0  Signal level:-70 dBm  Noise level:-98 dBm
>            Rx invalid nwid:59  Rx invalid crypt:0  Rx invalid frag:0
>            Tx excessive retries:1  Invalid misc:4900   Missed beacon:3

It seems like if you have bunch of rx invalid nwids... it could be due to 
interference from another wireless network in the area?

Regards,

.lzs

