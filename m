Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263651AbTIHUKH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbTIHUKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:10:07 -0400
Received: from lns-th2-4f-81-56-212-215.adsl.proxad.net ([81.56.212.215]:49801
	"EHLO maverick.eskuel.net") by vger.kernel.org with ESMTP
	id S263651AbTIHUKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:10:02 -0400
Message-ID: <3F5CE25A.4020003@eskuel.net>
Date: Mon, 08 Sep 2003 22:11:06 +0200
From: Mathieu LESNIAK <maverick@eskuel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: Fs corruption with swsusp in test4-mm6 ?
References: <Pine.LNX.4.33.0309081239400.972-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0309081239400.972-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
>>vs-4080: reiserfs_free_block: free_block (hda2:95121)[dev:blocknr]: bit 
>>already cleared
>>Sep  6 10:30:51 herrbach kernel: vs-4080: reiserfs_free_block: 
>>free_block (hda2:95122)[dev:blocknr]: bit already cleared
>>Sep  6 10:30:58 herrbach kernel: vs-13060: reiserfs_update_sd: stat data 
>>of object [689 645 0x0 SD] (nlink == 1) not found (pos 25)
>>Sep  6 10:30:58 herrbach kernel: vs-13060: reiserfs_update_sd: stat data 
>>of object [689 652 0x0 SD] (nlink == 1) not found (pos 25)
> 
> 
> Could someone that is familar with reiserfs comment as to what exactly is 
> happening? 
> 
> Mathieu, did you notice this with any of the earlier -test4-mm6 kernels, 
> or just -mm6? 
> 
> Thanks,
> 
> 
> 	Pat
> 

Hi,

I haven't tested previous -test4-mm patches before this one, so I 
couldn't tell you :(
In addition, as I said to Pavel in private mail, this laptop is not 
mine, and I won't be able to execute more tests on it.

Mathieu LESNIAK

