Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265320AbTL0FCQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 00:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265321AbTL0FCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 00:02:16 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:51900 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265320AbTL0FCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 00:02:15 -0500
Date: Fri, 26 Dec 2003 21:02:03 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Rob Love <rml@ximian.com>, Stan Bubrouski <stan@ccs.neu.edu>
cc: azarah@nosferatu.za.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 sound output - wierd effects
Message-ID: <8970000.1072501322@[10.10.2.4]>
In-Reply-To: <1072500888.4136.3.camel@fur>
References: <1080000.1072475704@[10.10.2.4]> <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]> <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]> <1072482611.21020.71.camel@nosferatu.lan>  <2060000.1072483186@[10.10.2.4]> <1072500516.12203.2.camel@duergar> <1072500888.4136.3.camel@fur>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Please do, while it would be nice if OSS could be dropped altogether
>> there are a great many commercial and closed source apps that we all
>> need and only currently work with OSS.  For example flash player for
>> linux and real player, not to mention a myrid of open source apps that
>> have yet to move to ALSA support.  Right now its virtually impossible to
>> live with a kernel with no OSS for people like me who require use of
>> these apps on a daily basis.
> 
> Why isn't the OSS emulation layer sufficient?

Because someone broke it ... that's what this thread is about ;-)

Between test2 and test3. I'm guessing it's "ALSA 0.9.6 update" -
backing that out from test3 right now, and restesting ...

M.

