Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVBJLIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVBJLIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 06:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVBJLHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 06:07:46 -0500
Received: from ip213-185-37-13.laajakaista.mtv3.fi ([213.185.37.13]:1664 "EHLO
	three.holviala.com") by vger.kernel.org with ESMTP id S262098AbVBJLHj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 06:07:39 -0500
Message-ID: <420B4077.6000304@holviala.com>
Date: Thu, 10 Feb 2005 13:07:35 +0200
From: Kim Holviala <kim@holviala.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kim Holviala <kim@holviala.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Spontaneous reboot with 2.6.10 and NFSD
References: <420B0FCD.4000801@holviala.com> <16907.10130.293919.399727@cse.unsw.edu.au> <420B2B01.5020206@holviala.com>
In-Reply-To: <420B2B01.5020206@holviala.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kim Holviala wrote:

>> Also, what filesystem is being used on the server, what mount flags
>> (if any) and what export options.
> 
> All the files are here:
> http://www.holviala.com/~kimmy/crash/mount

Umph... Actually, the files are here:
http://www.holviala.com/~kimmy/crash/

> Mount options:
> /dev/md8 on /boot type ext3 (rw,nosuid,noatime)

And that was for a wrong fs, but the options were the same.

> I forgot to transfer the exports file, and now the server is dead... 
> Will do that later.

Exports is now in the same place as other files. Here's the relevant line:
/export/home		*(rw,sync)




Kim
