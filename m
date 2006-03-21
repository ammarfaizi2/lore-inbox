Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWCURcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWCURcA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWCURb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:31:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:43674 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932335AbWCURb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:31:58 -0500
Date: Tue, 21 Mar 2006 18:31:36 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Dike <jdike@addtoit.com>
cc: Matheus Izvekov <mizvekov@gmail.com>, Neil Brown <neilb@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Who uses the 'nodev' flag in /proc/filesystems ???
In-Reply-To: <20060321003205.GA7860@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.61.0603211830380.21376@yvahk01.tjqt.qr>
References: <17436.60328.242450.249552@cse.unsw.edu.au>
 <Pine.LNX.4.61.0603191024420.1409@yvahk01.tjqt.qr> <17438.13214.307942.212773@cse.unsw.edu.au>
 <Pine.LNX.4.61.0603201659250.22395@yvahk01.tjqt.qr>
 <305c16960603200817u3c8e4023nf2621245fdb0ed65@mail.gmail.com>
 <20060320175633.GA5797@ccure.user-mode-linux.org>
 <305c16960603201122t79dd93c1t484c83acf4ed191b@mail.gmail.com>
 <20060320194815.GA6376@ccure.user-mode-linux.org>
 <Pine.LNX.4.61.0603202057420.14231@yvahk01.tjqt.qr>
 <20060321003205.GA7860@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Mon, Mar 20, 2006 at 08:58:58PM +0100, Jan Engelhardt wrote:
>> But hey, when hostfs is nodev-but-fsckable, then looking for /sbin/fsck.XYZ 
>> is even better than reading /proc/filesystems...
>
>It's humfs, BTW (hostfs consistency is maintained by the host), but yes.
>

humm. Hm! Calls for buzzfs. :)


Jan Engelhardt
-- 
