Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265628AbTF2LHh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 07:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265629AbTF2LHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 07:07:36 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:20657 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265628AbTF2LHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 07:07:36 -0400
Message-ID: <3EFECBD1.9010409@namesys.com>
Date: Sun, 29 Jun 2003 15:21:53 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "burnt_2@ziplip.com" <burnt_2@ziplip.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: inode problem?
References: <MIJXCMB2BYF3IGODGJJ4OJOIOEKCMGEAGNADOJMH@ziplip.com>
In-Reply-To: <MIJXCMB2BYF3IGODGJJ4OJOIOEKCMGEAGNADOJMH@ziplip.com>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

burnt_2@ziplip.com wrote:

>Hans Reiser wrote:
>
>  
>
>>inodes are yucky yucky.;-) We ain't got none.
>>    
>>
>
>So are birthday problems and hash collisions, but I haven't seen you guys address that little detail yet...
>
V4 handles duplicates, and has a larger hash.

>
>(Speaking only as somebody who lost their /usr/local tree to reiserfs.  KEEP BACKUPS, especially if you're using an experimental filesystem.)
>
>
>  
>
Sorry that happened to you.  Were you using a kernel older than 2.4.18? 

-- 
Hans


