Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269442AbUI3T7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269442AbUI3T7O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269469AbUI3T7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:59:14 -0400
Received: from [62.206.217.67] ([62.206.217.67]:46259 "EHLO gw.localnet")
	by vger.kernel.org with ESMTP id S269442AbUI3T7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:59:03 -0400
Message-ID: <415C6582.2090405@trash.net>
Date: Thu, 30 Sep 2004 21:58:58 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Frank van Maarseveen <frankvm@xs4all.nl>
CC: Christian <evil@g-house.de>, linux-kernel@vger.kernel.org
Subject: Re: ip_nat_helper  / ip_conntrack_core issues with recent 2.6 kernels
References: <4137B825.8080801@g-house.de> <20040930193945.GA10777@janus>
In-Reply-To: <20040930193945.GA10777@janus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen wrote:

>I see that one too in 2.6.9-rc2:
>Sep 30 21:33:47 iapetus kernel: NF_IP_ASSERT: net/ipv4/netfilter/ip_conntrack_core.c:658(init_conntrack)
>Sep 30 21:34:30 iapetus last message repeated 3 times
>Sep 30 21:35:38 iapetus last message repeated 4 times
>
>while lftp'ing to get -rc3. No problems doing so.
>  
>
It's harmless and already fixed in -rc3.

Regards
Patrick

