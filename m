Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263678AbUCURNJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 12:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUCURNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 12:13:09 -0500
Received: from smtp.mailix.net ([216.148.213.132]:61392 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S263678AbUCURNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 12:13:07 -0500
Message-ID: <405D239B.30602@mail.portland.co.uk>
Date: Sun, 21 Mar 2004 07:09:47 +0200
From: Jad Saklawi <saki@mail.portland.co.uk>
Reply-To: Jad Saklawi <jad@saklawi.info>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: hisham@hisham.cc, llug-users@greencedars.org
X-SA-Exim-Mail-From: saki@mail.portland.co.uk
Subject: Fwd: MAC / IP conflict
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: *  0.4 DATE_IN_PAST_12_24 Date: is 12 to 24 hours before Received: date
X-SA-Exim-Version: 3.1 (built Thu Oct 23 13:26:47 PDT 2003)
X-SA-Exim-Scanned: Yes
X-uvscan-result: clean (1B56Tx-0003PK-Ei)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Hisham Mardam Bey -----
    Date: Sun, 21 Mar 2004 13:52:59 +0200

In short, I need to detect when someone on the network uses my MAC and
my IP address.

Longer story follows. I am on a LAN which might have some potentially
dangerous users. Those users might spoof my MAC address and additionally
use my IP address, thus forcing my box to go offline, and not be able to
communicate with my gateway. What I need is a passive way to check for
something of the sort, and perhaps a notofication into syslog (the
latter is not very important).


