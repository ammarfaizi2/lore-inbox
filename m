Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270530AbTGZVXg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 17:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270583AbTGZVXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 17:23:35 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:30319
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S270530AbTGZVXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 17:23:02 -0400
Message-ID: <3F22F75D.8090607@rogers.com>
Date: Sat, 26 Jul 2003 17:49:17 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: WINE + Galciv + Con Kolivar's 09 patch to  2.6.0-test1-mm2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.157.78.60] using ID <dw2price@rogers.com> at Sat, 26 Jul 2003 17:37:37 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kudos to CK

In 2.4.21 galciv + wine was fine.

In 2.4.21 + CK patches, galvic + wine would pause every 15 seconds or so 
(maybe it was when little animations played).

In 2.6.0-test1-mm2 (vanilla, or + 08) Galciv would stutter horribly and 
freeze my machine in wine. It might run smoothly until I loaded a 
nautilus window or something then stutters and loss of control of the 
system.

With 09, it is smooth as silk until I do something and then the video 
playbacks can be choppy but the game (turn based strategy) seems to run 
without the long pauses of 2.4.21 CK or 2.6.0 vanilla. I can switch 
between apps and go back without any problem.

09 seems to be a big improvement for whatever caused the stutter & die 
problems in wine+galciv.

