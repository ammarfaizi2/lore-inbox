Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUF1SUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUF1SUy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 14:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbUF1SUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 14:20:54 -0400
Received: from mailout.zma.compaq.com ([161.114.64.103]:44805 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S264980AbUF1SUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 14:20:53 -0400
Message-ID: <40E062C1.4090705@hp.com>
Date: Mon, 28 Jun 2004 14:26:09 -0400
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ia64 kgdb
References: <40E05EF1.2070505@hp.com> <200406281113.01015.jbarnes@engr.sgi.com>
In-Reply-To: <200406281113.01015.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:

>On Monday, June 28, 2004 11:09 am, Robert Picco wrote:
>  
>
>>Hi Andrew:
>>
>>This fixes the broken kgdb patch.
>>    
>>
>
>Hey Bob, thanks for the patch.  Does the kgdb for ia64 require a special 
>version of gdb or is the latest one from gnu.org sufficient?  And does it 
>work with netconsole?
>
>Thanks,
>Jesse
>
>  
>
gdb-6.1 with patch at 
http://kernel.org/pub/linux/kernel/people/akpm/patches/gdb/gdb_patch_for_IA64_kgdb.  
It works with netconsole and serial. 

Bob

