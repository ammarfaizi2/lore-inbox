Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUDAIYa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 03:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbUDAIY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 03:24:29 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:45423 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262085AbUDAIY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 03:24:27 -0500
Message-ID: <406BD1B6.4090901@yahoo.com.au>
Date: Thu, 01 Apr 2004 18:24:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Cory Tusar <ctusar@adelphia.net>
CC: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] multiple namespaces
References: <1080800087.1490.14.camel@cube> <406BC690.2080803@adelphia.net>
In-Reply-To: <406BC690.2080803@adelphia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cory Tusar wrote:
> Albert Cahalan wrote:
> 
>> +/* drive letter support */
>> +#define PR_GET_DRIVE 42     /* get the current drive */
>> +#define PR_SET_DRIVE 69     /* set the current drive */
>> +#define PR_SUBST_CREATE 666   /* associate a drive letter with 
>> something */
>> +#define PR_SUBST_DESTROY 20040401   /* kill a drive letter */
> 
> 
> My bogometer just twitched...
> 

Your april-foolometer, perhaps? :)
