Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTEIXig (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbTEIXig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:38:36 -0400
Received: from port-212-202-185-50.reverse.qdsl-home.de ([212.202.185.50]:32135
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S263580AbTEIXif
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:38:35 -0400
Message-ID: <3EBC3E94.5020000@trash.net>
Date: Sat, 10 May 2003 01:49:40 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030430 Debian/1.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix kfree(skb) in iphase driver
References: <200305092310.h49NAnGi011053@locutus.cmf.nrl.navy.mil>
In-Reply-To: <200305092310.h49NAnGi011053@locutus.cmf.nrl.navy.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



chas williams wrote:

>In message <3EBAD2F1.9090802@trash.net>,Patrick McHardy writes:
>  
>
>>This patch fixes a kfree(skb) in the iphase driver.
>>    
>>
>
>what release is this against?
>

2.4.21-rc1 couple of changesets before -rc2, still applies.

Patrick

