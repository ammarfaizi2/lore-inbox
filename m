Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265624AbTHGRTW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 13:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268737AbTHGRTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 13:19:06 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:62701 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262123AbTHGRTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 13:19:02 -0400
Message-ID: <3F326E24.5000907@cornell.edu>
Date: Thu, 07 Aug 2003 11:20:04 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs4
References: <200308070305.51868.vlad@lazarenko.net> <20030806230220.I7752@schatzie.adilger.int> <3F31DFCC.6040504@cornell.edu> <20030807072751.GA23912@namesys.com>
In-Reply-To: <20030807072751.GA23912@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is no longer true.
> There is sort of "universal" fs convertor for linux that can convert almost
> any fs to almost any other fs.
> The only requirement seems to be that both fs types should have read/write support in Linux.
> http://tzukanov.narod.ru/convertfs/

Tried the tool.
Didn't work for me, and I was told by the author that it requires 50% 
space for operation..which defeats the purpose for which I was hoping to 
use it (lack of space). If it works with 50% free, I suppose it will 
make people's lives easier, though the same could be achieved with a few 
resizes and parted. I was more interested in something that requires 
very little space to operate and is able to convert the fs.





