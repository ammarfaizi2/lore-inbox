Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318694AbSHAJm5>; Thu, 1 Aug 2002 05:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318688AbSHAJl7>; Thu, 1 Aug 2002 05:41:59 -0400
Received: from [195.63.194.11] ([195.63.194.11]:15108 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318689AbSHAJju>; Thu, 1 Aug 2002 05:39:50 -0400
Message-ID: <3D4848D5.9080208@evision.ag>
Date: Wed, 31 Jul 2002 22:30:13 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
References: <20020730225359.GA17826@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Hi,
> 
> When devfs came alone, it created devfs_[un]register_chrdev and
> devfs_[un]register_blkdev, which required that all drivers be changed to
> be compatible with devfs. This change has been bothering a lot of people
> for quite some time :)

Thanks! Finally someone got annoyed enough.


