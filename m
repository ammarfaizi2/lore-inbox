Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266340AbUAHWwJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266323AbUAHWwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:52:09 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:23224 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S266354AbUAHWwE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:52:04 -0500
Message-ID: <3FFDDF0C.7080307@rackable.com>
Date: Thu, 08 Jan 2004 14:51:56 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Zenczykowski <maze@cela.pl>
CC: Gene Heskett <gene.heskett@verizon.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Howto use diff compatibly
References: <Pine.LNX.4.44.0401082300421.1739-100000@gaia.cela.pl>
In-Reply-To: <Pine.LNX.4.44.0401082300421.1739-100000@gaia.cela.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jan 2004 22:52:01.0946 (UTC) FILETIME=[078A57A0:01C3D63A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Zenczykowski wrote:
>>I have a better idea.  Who is the current maintainer for 
>>drivers/block/floppy.c?
> 
> 
> Check MAINTAINERS for floppy
> 
> linux 2.4.23:
> 
> IDE/ATAPI FLOPPY DRIVERS
> P:      Paul Bristow
> M:      Paul Bristow <paul@paulbristow.net>
> W:      http://paulbristow.net/linux/idefloppy.html
> L:      linux-kernel@vger.kernel.org
> S:      Maintained
> 

   That would be the maintainer for drivers/ide/ide-floppy.c.  I don't 
think there is a maintainer for drivers/block/floppy.c.

-- 
Unless you can't avoid it never put a
serial number on any of your systems!!
(The Numberless Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

