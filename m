Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270778AbTG0NqM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 09:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270776AbTG0NqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 09:46:12 -0400
Received: from nic.bme.hu ([152.66.115.1]:27606 "EHLO nic.bme.hu")
	by vger.kernel.org with ESMTP id S270778AbTG0NqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 09:46:08 -0400
Message-ID: <3F23DABC.1090003@namesys.com>
Date: Sun, 27 Jul 2003 17:59:24 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tomas Szepe <szepe@pinerecords.com>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] use ext2/ext3 consistently in Kconfig
References: <20030726195722.GB16160@louise.pinerecords.com> <1059303927.12758.10.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1059303927.12758.10.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Sad, 2003-07-26 at 20:57, Tomas Szepe wrote:
>  
>
>>$subj + also clarify what fs versions the current reiser module supports.
>>Patch against -bk3.          
>>    
>>
>
>
>  
>
>>This is the journaling version of the Second extended file system
>>    
>>
>-         (often called ext3), the de facto standard Linux file system
>+         (often called ext2), the de facto standard Linux file system
>          (method to organize files on a storage device) for hard disks.
>
>It is called ext3 not ext2. This change is dubious (actually the big
>problem is it is totally unclear what we are discussing the name of.
>How about
>
>  Ext3 is the journalling versions of the second extended file system
>(ext2). Ext2 was the former de-facto standard Linux file system
>
on redhat.... or did you mean long ago.... ;-)

>. Ext3
>uses the same on disk layout but with a journal.
> ...
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


-- 
Hans


