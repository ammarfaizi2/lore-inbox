Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbTJGQPS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 12:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbTJGQPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 12:15:06 -0400
Received: from smtp1.freeserve.com ([193.252.22.158]:56114 "EHLO
	mwinf3002.me.freeserve.com") by vger.kernel.org with ESMTP
	id S262467AbTJGQOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 12:14:55 -0400
Message-ID: <30270451.1065543294483.JavaMail.www@wwinf3005>
From: tigran@aivazian.fsnet.co.uk
Reply-To: tigran@aivazian.fsnet.co.uk
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: Re: [PATCH] [2.4.XX] Silicon Image/CMD Medley Software RAID
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Date: Tue,  7 Oct 2003 18:14:54 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Mark!

I put linux-kernel back, in case someone else has ideas.

> what controller does it have?  the web page, sadly, doesn't give lspci output ;)

I will check it (the card is at home and I am in the office) and let you know.
>From memory it was something like:

"Silicon Image PCI0680"

(or something like that)

> 
> the correct term is "broken", not "slow".
> 

Well, if it, as you say, works in "ata compatibility mode"
and there is no specific driver (in Linux) then it is not
broken but (currently, under Linux) just _very_ slow,
until someone writes a specific driver for that chipset.

But I am not interested in subtle semantics of "slow" vs "broken".
All I want is for my data to arrive at the disk (and come back, sometimes)
a bit faster! :)

Kind regards
Tigran
