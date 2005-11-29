Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbVK2J3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVK2J3T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 04:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbVK2J3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 04:29:19 -0500
Received: from ihug-mail.icp-qv1-irony1.iinet.net.au ([203.59.1.195]:5416 "EHLO
	mail-ihug.icp-qv1-irony1.iinet.net.au") by vger.kernel.org with ESMTP
	id S1750929AbVK2J3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 04:29:18 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Message-ID: <438C1F68.4070707@eyal.emu.id.au>
Date: Tue, 29 Nov 2005 20:29:12 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc3 - VIDEO_BT848_DVB config
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I just pushed 2.6.15-rc3 out there, and here are both the shortlog and 
> diffstats appended.

A config issue? It says 'choose M' which is not offered. Maybe it is just
an option for the bt8xx driver, which itself can be built as a module
(CONFIG_VIDEO_BT848)?


  DVB/ATSC Support for bt878 based TV cards (VIDEO_BT848_DVB) [N/y/?] (NEW) ?

This adds support for DVB/ATSC cards based on the BT878 chip.

To compile this driver as a module, choose M here: the
module will be called dvb-bt8xx.

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
