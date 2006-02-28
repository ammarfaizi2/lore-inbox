Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWB1Cp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWB1Cp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 21:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWB1Cp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 21:45:58 -0500
Received: from relay1.es.uci.edu ([128.200.73.41]:43455 "EHLO
	relay1.es.uci.edu") by vger.kernel.org with ESMTP id S932127AbWB1Cp6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 21:45:58 -0500
X-UCInetID: fkruggel
Message-ID: <4403B964.40905@uci.edu>
Date: Mon, 27 Feb 2006 18:45:56 -0800
From: Frithjof Kruggel <fkruggel@uci.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.7.12) Gecko/20060207 Debian/1.7.12-1.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, fkruggel@uci.edu
Subject: aic79xx + tape 2.6.13.5 -> 2.6.15.4 problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to bother you with this. I have a server
system equipped with an Adaptec U320 board,
attached a HP Ultrium 2 drive.
Since I upgraded from kernel version 2.6.13.5
to 2.6.15.4, tape write speeds dropped from
22 MB/s to 4.5 MB/s. Looks like asynchonous
write mode is now negotiated.
Any help is appreciated - please, cc to my
address above as I am not a regular reader.
Thanks,

Frithjof
