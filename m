Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWBYWIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWBYWIU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWBYWIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:08:20 -0500
Received: from main.gmane.org ([80.91.229.2]:31393 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751056AbWBYWIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:08:18 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: [Announce] Intel PRO/Wireless 3945ABG Network Connection
Date: Sat, 25 Feb 2006 23:07:54 +0100
Message-ID: <pan.2006.02.25.22.07.53.810642@free.fr>
References: <43FF88E6.6020603@linux.intel.com> <20060225084139.GB22109@infradead.org> <200602250549.47547.gene.heskett@verizon.net> <Pine.LNX.4.61.0602251518200.31692@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Cc: netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

Le Sat, 25 Feb 2006 15:19:40 +0100, Jan Engelhardt a écrit :

>>If the modules crc changes, 
>>it must do an instant disable of the transmitter functions and exit or 
>>crash, thereby precluding any 'hot rodding' of the chipset.
>>
> Would not it be easiest to have the chipset enforce the acceptable bands? 
> So that software can't switch the chipset to 1337 GHz no matter how hard 
> you forward/reverse-engineer it.
> 
I will say, why not put the restriction of the firmware binary blob ?
It run on the device so it will be difficult for people to analyse it.

Also the firmware could be on a eeprom and transparent for the user.


Matthieu


