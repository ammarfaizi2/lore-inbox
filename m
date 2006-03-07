Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751702AbWCGGQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbWCGGQT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 01:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWCGGQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 01:16:19 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:64632 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750812AbWCGGQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 01:16:19 -0500
Message-ID: <440D2633.4070301@sw.ru>
Date: Tue, 07 Mar 2006 09:20:35 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Kirill Korotaev <dev@openvz.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Olaf Hering <olh@suse.de>,
       Jan Blunck <jblunck@suse.de>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
References: <17414.38749.886125.282255@cse.unsw.edu.au>	<17419.53761.295044.78549@cse.unsw.edu.au>	<440C236A.90700@openvz.org> <17420.59753.598191.388029@cse.unsw.edu.au>
In-Reply-To: <17420.59753.598191.388029@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>In general your patch is still does what mine do, so I will be happy if 
>>any of this is commited mainstream. In future, please, keep the 
>>reference to original authors, this will also make sure that I'm on CC 
>>if something goes wrong.
> 
> 
> Sorry: which 'original author' did I miss ?
I mean, it is better to mention original author 
(http://marc.theaimsgroup.com/?l=linux-kernel&m=114123870406751&w=2) in 
patch description, as it makes sure that he will be on CC if this patch 
will be discussed later again. My patch fixing this race was in -mm tree 
for half a year already.

Thanks,
Kirill


