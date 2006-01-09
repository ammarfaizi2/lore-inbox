Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWAIQS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWAIQS1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWAIQS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:18:26 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:39640 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964805AbWAIQS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:18:26 -0500
Date: Mon, 9 Jan 2006 17:18:22 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs mount time
In-Reply-To: <1136763077.2997.4.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0601091717400.26210@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0601082320520.2801@yvahk01.tjqt.qr>
 <1136763077.2997.4.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> brought to attentino on an irc channel, reiser seems to have the largest 
>> mount times for big partitions. I see this behavior on at least two 
>> machines (160G, 250G) and one specially-crafted virtual machine
>> (a 1.9TB disk / 1.9TB partition - took somewhere over 120 seconds).
>> Here's a dig http://linuxgazette.net/122/misc/piszcz/group001/image002.png 
>> from http://linuxgazette.net/122/TWDT.html#piszcz
>> So, any hint from the reiserfs developers how come reiserfs takes so long?
>> Standard mkreiserfs options (none extra passed).
>
>reiser3 or reiser4?

For my case, reiser3.

(According to that pic link (from irc) also reiser4, but I'm inclined not 
to believe that one.)


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
