Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVCYVBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVCYVBE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 16:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVCYVBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 16:01:04 -0500
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:1432 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S261797AbVCYVA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:00:58 -0500
Message-ID: <42447C02.1010308@austin.rr.com>
Date: Fri, 25 Mar 2005 15:00:50 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][0/5] cifs: cifsfs.c cleanup
References: <Pine.LNX.4.62.0503251816530.2498@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0503251816530.2498@dragon.hyggekrogen.localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

>Hi Steve,
>
>Here are the cleanups for fs/cifs/cifsfs.c
>
>More or less the same drill as with the previous round of patches. I'll 
>submit the patches inline, but once again they are available for you 
>online if needed (I've included the notes about the specific patch in 
>those files this time) : 
>
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_cifsfs-whitespace-function-defs.patch
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_cifsfs-whitespace-spaces.patch
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_cifsfs-whitespace-comments.patch
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_cifsfs-nesting.patch
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_cifsfs-casts.patch
>
>(listed in the order they apply)
>  
>
Today I applied the cifsfs_casts patch (and similary I applied the 
similar patch to readdir.c and the kfree patch to readdir.c).
The changes were mostly minor due to the patches reminding of places 
where I had to clarify comments.

I didn't have time to review the rest.

Thanks.


