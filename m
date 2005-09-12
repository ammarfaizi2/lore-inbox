Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVILSyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVILSyz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVILSyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:54:55 -0400
Received: from mail.dvmed.net ([216.237.124.58]:11168 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932095AbVILSyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:54:54 -0400
Message-ID: <4325CEFA.6050307@pobox.com>
Date: Mon, 12 Sep 2005 14:54:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: abonilla@linuxwireless.org
CC: netdev@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       ieee80211-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Git broken for IPW2200
References: <1126143695.5402.11.camel@localhost.localdomain>
In-Reply-To: <1126143695.5402.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alejandro Bonilla Beeche wrote:
> Hi,
> 
> 	Where does one report this? I was building Linus Git tree as per I
> updated it at 09/07/2005 7:00PM PDT and got this while compiling.
> 
> Where do I report this?
> 
> Debian unstable updated at same time.
> 
> it looks like ipw2200 is thinking that ieee80211 is not compiled in, but
> I did select it as a module?

Care to send your .config?

	Jeff



