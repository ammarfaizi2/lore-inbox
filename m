Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130011AbQKJHlE>; Fri, 10 Nov 2000 02:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130575AbQKJHkz>; Fri, 10 Nov 2000 02:40:55 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:56077 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S130011AbQKJHkk>; Fri, 10 Nov 2000 02:40:40 -0500
From: aprasad@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: bsuparna@in.ibm.com
cc: linux-kernel@vger.kernel.org
Message-ID: <CA256993.0026C8BD.00@d73mta05.au.ibm.com>
Date: Fri, 10 Nov 2000 12:25:24 +0530
Subject: Re: Oddness in i_shared_lock and page_table_lock nesting
	 hierarchies ?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Reply-To: aprasad@in.ibm.com
X-created: Reply-To created by f03n05e.au.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I was looking into the vmm code and trying to work out exactly how to fix
>this, and there are
>  some questions in my mind - mainly a few cases (involving multiple vma
>updates) which
>  I'm not sure about the cleanest way to tackle.
>  But before I bother anyone with those, I thought I ought to go through
>the earlier discussions
>  that you had while coming up with what the fix should be. Maybe you've
>already gone over
>  this once.
>  Could you point me to those ? Somehow I haven't been successful in
>locating them.

this link might be useful
http://mail.nl.linux.org/linux-mm/2000-07/msg00038.html

Anil Kumar Prasad,
Hardware Design,
IBM Global Services,
Pune,
INDIA
Phone:6349724 , 4007117 extn:1310


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
