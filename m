Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267713AbTAMBZj>; Sun, 12 Jan 2003 20:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267743AbTAMBZi>; Sun, 12 Jan 2003 20:25:38 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:125 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S267713AbTAMBZh>; Sun, 12 Jan 2003 20:25:37 -0500
Message-ID: <3E221759.3050409@blue-labs.org>
Date: Sun, 12 Jan 2003 20:33:13 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030110
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.56 panics PostgreSQL
References: <3E21B839.4060902@blue-labs.org>	 <200301121137.07735.akpm@digeo.com>  <3E21C794.6070606@blue-labs.org> <1042420508.31100.1180.camel@tiny.suse.com>
In-Reply-To: <1042420508.31100.1180.camel@tiny.suse.com>
X-Enigmail-Version: 0.71.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I can in short order.  Let me grab my notebook and get a kernel w/ 
serial console going.

David

Chris Mason wrote:

>On Sun, 2003-01-12 at 14:52, David Ford wrote:
>  
>
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>Reiserfs.  Postgres is the only program that had problems, but it's also
>>the one that does 99% of all the activity on the system.
>>    
>>
>
>Do you still have any of the oopsen?
>
>-chris
>
>  
>

- -- 
I may have the information you need and I may choose only HTML.  It's up to you. Disclaimer: I am not responsible for any email that you send me nor am I bound to any obligation to deal with any received email in any given fashion.  If you send me spam or a virus, I may in whole or part send you 50,000 return copies of it. I may also publically announce any and all emails and post them to message boards, news sites, and even parody sites.  I may also mark them up, cut and paste, print, and staple them to telephone poles for the enjoyment of people without internet access.  This is not a confidential medium and your assumption that your email can or will be handled confidentially is akin to baring your backside, burying your head in the ground, and thinking nobody can see you butt nekkid and in plain view for miles away.  Don't be a cluebert, buy one from K-mart today.

When it absolutely, positively, has to be destroyed overnight.
                           AIR FORCE

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+Ihdc74cGT/9uvgsRAiTaAJ42qZ/WZyueTYpaDK6/e0WOIXJ82ACcCMDT
gmvHVssrIRcwwC8OXOGgIgQ=
=K5/f
-----END PGP SIGNATURE-----

