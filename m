Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269833AbUH0ADo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269833AbUH0ADo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269826AbUH0ABV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:01:21 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:18866 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269792AbUHZXxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:53:55 -0400
Message-ID: <412E780F.7000009@namesys.com>
Date: Thu, 26 Aug 2004 16:53:51 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>	 <20040825200859.GA16345@lst.de> <20040825201929.GA16855@lst.de>	 <412DA25E.9090405@namesys.com> <1093527487.21878.270.camel@watt.suse.com>
In-Reply-To: <1093527487.21878.270.camel@watt.suse.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>
>
>If the early linux filesystems had taken the same attitude you have
>(don't write new filesystems, only write plugins), there would be no
>framework allowing the wealth of filesystems we do have, including
>reiser4.
>
>  
>
Au contraire, with my approach, there would be 10x as many filesystems, 
because people would be easily able to mix-and-match different methods 
and plugins from different filesystems together, and if you wanted the 
MySQL semantics, you would mount mysql, and if you wanted the zope 
semantics you would mount zope.
