Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVBGTyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVBGTyw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVBGTxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:53:36 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:24058 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261293AbVBGTwK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:52:10 -0500
Message-ID: <4207C6E6.3080602@tiscali.de>
Date: Mon, 07 Feb 2005 20:52:06 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: user-mode-linux-user@lists.sourceforge.net, matthias.christian@tiscali.de
Subject: Linux Virtual Network Device
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I have the following the problem:
I have server which is connected to the internet via a gateway, on this 
server I want to run some uml machines. I want "equip" every uml machine 
with virtual network device (virX [e.g.; the name doesn't matter]). The 
virtual devices should be something like the "lo" device and their ip 
addresses shouldn't be used by the internet (I'm looking for something 
like 127.0.0.1). I want to give each uml machine a host name (e.g. 
xxx.myserver.mydomain.com), requests should be masqueraded (by bind or 
dnsmasq?) by their dns name (1.myserver.mydomain.com is 127.0.0.2 
[vir0]). How to do this?

Links or Tutorials are welcome (I just found some outdated stuff on the 
uml website)

Thanks
Matthias-Christian Ott
