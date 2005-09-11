Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVIKBZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVIKBZS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 21:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVIKBZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 21:25:18 -0400
Received: from mail.collax.com ([213.164.67.137]:13481 "EHLO
	kaber.coreworks.de") by vger.kernel.org with ESMTP id S932385AbVIKBZR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 21:25:17 -0400
Message-ID: <4323877A.4050309@trash.net>
Date: Sun, 11 Sep 2005 03:25:14 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050803 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Linux-Kernel Lista <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org
Subject: Re: 2.6.13-mm2
References: <20050908053042.6e05882f.akpm@osdl.org>	<1126396015l.6300l.1l@werewolf.able.es>	<20050910165659.5eea90d0.akpm@osdl.org> <4323753D.9030007@trash.net>	<1126399776l.6300l.2l@werewolf.able.es>	<1126400288l.6300l.3l@werewolf.able.es> <43238259.505@trash.net> <1126401757l.6556l.0l@werewolf.able.es>
In-Reply-To: <1126401757l.6556l.0l@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> On 09.11, Patrick McHardy wrote:
> 
>>[NETFILTER]: Don't exclude local packets from MASQUERADING
>>
> Thanks, reverting this made things work again.
> 
> Are you confident in fixing this shortly, or should I just drop pump ?

I should have a fix within the next couple of days.
