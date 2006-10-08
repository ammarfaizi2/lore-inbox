Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWJHEn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWJHEn7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 00:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWJHEn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 00:43:59 -0400
Received: from mx2.netapp.com ([216.240.18.37]:32262 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1750718AbWJHEn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 00:43:57 -0400
X-IronPort-AV: i="4.09,276,1157353200"; 
   d="scan'208"; a="416033891:sNHT29414772"
Subject: Re: 2.6.19-rc1: known regressions (v2)
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Adrian Bunk <bunk@stusta.de>
Message-ID: <EXSVLRB01xe0ymQ1WE900000265@exsvlrb01.hq.netapp.com>
X-OriginalArrivalTime: 08 Oct 2006 04:43:51.0606 (UTC) FILETIME=[5A341560:01C6EA94]
Date: 7 Oct 2006 21:43:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, art@usfltd.com, ak@suse.de, discuss@x86-64.org,  Prakash Punnoor <prakash@punnoor.de>, perex@suse.cz, alsa-devel@alsa-project.org, Steve Fox <drfickle@us.ibm.com>,  netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>,  len.brown@intel.com, linux-acpi@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,  Olaf Hering <olaf@aepfle.de>, Antonino Daplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net,  Thierry Vignaud <tvignaud@mandriva.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Ernst Herzberg <list-lkml@net4u.de>, Matthieu Castet <castet.matthieu@free.fr>,  linux-usb-devel@lists.sourceforge.net, Jens Axboe <axboe@oracle.com>,  Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pm@osdl.org, linuxppc-dev@ozlabs.org, Andreas Schwab <schwab@suse.de>,  Mel Gorman <mel@skynet.ie>, Alex Romosan <romosan@sycorax.lbl.gov>, Sukadev Bhattiprolu <sukadev@us.ibm.!
 com>, Dave Kleikamp <shaggy@austin.ibm.com>, Torsten Kaiser <kernel@bardioc.dyndns.org>, Magnus Damm <magnus.damm@gmail.com>, Vivek Goyal <vgoyal@in.ibm.com>, ebiederm@xmission.com, fastboot@osdl.org, Alistair John Strachan <s0348365@sms.ed.ac.uk>, Stefan Richter <stefanr@s5r6.in-berlin.de>,  linux1394-devel@lists.sourceforge.net
In-Reply-To: <20061007214620.GB8810@stusta.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	 <20061007214620.GB8810@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Sun, 08 Oct 2006 00:43:35 -0400
Message-Id: <1160282615.5506.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 

On Sat, 2006-10-07 at 23:46 +0200, Adrian Bunk wrote:

> Subject    : NFSv4 fails to mount (timeout)
> References : http://bugzilla.kernel.org/show_bug.cgi?id=7274
> Submitter  : Torsten Kaiser <kernel@bardioc.dyndns.org>
> Guilty     : Trond Myklebust <Trond.Myklebust@netapp.com>
>              commit 51b6ded4d9a94a61035deba1d8f51a54e3a3dd86
> Handled-By : Trond Myklebust <Trond.Myklebust@netapp.com>
> Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=7274
> Status     : patch available

Thanks... Always nice to hear that you have been judged and found
guilty. Now go and reread that fucking bug report...

