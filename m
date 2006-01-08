Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161243AbWAHXbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161243AbWAHXbX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 18:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbWAHXbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 18:31:23 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:30180 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161243AbWAHXbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 18:31:22 -0500
Subject: Re: reiserfs mount time
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0601082320520.2801@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0601082320520.2801@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Sun, 08 Jan 2006 18:31:17 -0500
Message-Id: <1136763077.2997.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-08 at 23:24 +0100, Jan Engelhardt wrote:
> Hi,
> 
> 
> brought to attentino on an irc channel, reiser seems to have the largest 
> mount times for big partitions. I see this behavior on at least two 
> machines (160G, 250G) and one specially-crafted virtual machine
> (a 1.9TB disk / 1.9TB partition - took somewhere over 120 seconds).
> Here's a dig http://linuxgazette.net/122/misc/piszcz/group001/image002.png 
> from http://linuxgazette.net/122/TWDT.html#piszcz
> So, any hint from the reiserfs developers how come reiserfs takes so long?
> Standard mkreiserfs options (none extra passed).
> 

reiser3 or reiser4?

Lee

