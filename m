Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267368AbTB1B16>; Thu, 27 Feb 2003 20:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267384AbTB1B16>; Thu, 27 Feb 2003 20:27:58 -0500
Received: from gaea.projecticarus.com ([195.10.228.71]:62862 "EHLO
	gaea.projecticarus.com") by vger.kernel.org with ESMTP
	id <S267368AbTB1B15>; Thu, 27 Feb 2003 20:27:57 -0500
Message-ID: <3E5EBD52.4030902@walrond.org>
Date: Fri, 28 Feb 2003 01:37:22 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Patch: 2.5.62 devfs shrink
References: <200302272313.PAA11724@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I assume you meant devfs_helper here:

 > devfsd is not a deamon.  Instead, the new devfs invokes devfs_helper
   ------

Looks good to me. I want to give this another whirl, but your latest 
patch doesn't apply cleanly against 2.5.63+ (fs/devfs/base.c fails). Any 
chance of an update?

Thanks

Andrew Walrond

