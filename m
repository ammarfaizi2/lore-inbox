Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUB0S6E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbUB0S6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:58:04 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:20101 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261723AbUB0S54
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:57:56 -0500
Message-ID: <403F9332.7040804@namesys.com>
Date: Fri, 27 Feb 2004 21:57:54 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: markw@osdl.org, piggin@cyberone.com.au, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: AS performance with reiser4 on 2.6.3
References: <403EBB87.2070504@namesys.com>	<200402271704.i1RH45E19258@mail.osdl.org> <16447.31708.873806.565855@laputa.namesys.com>
In-Reply-To: <16447.31708.873806.565855@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>markw@osdl.org writes:
> > 
> > Yes, PostgreSQL uses fsync for its database logging.  I can certainly
> > enable the capture on copy option.  
>
>Please don't, it is not stable enough yet.
>  
>
It will be stable enough when we release on Monday though, yes?

> >                                     Does that produce something that I
> > need to manually capture?
> > 
> > Mark
>
>Nikita.
>
>
>  
>


-- 
Hans


