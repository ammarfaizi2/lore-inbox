Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264378AbTCXSCa>; Mon, 24 Mar 2003 13:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264389AbTCXSCa>; Mon, 24 Mar 2003 13:02:30 -0500
Received: from intra.cyclades.com ([64.186.161.6]:7818 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP
	id <S264378AbTCXSC3>; Mon, 24 Mar 2003 13:02:29 -0500
Message-ID: <3E7ED9DF.5020909@cyclades.com>
Date: Mon, 24 Mar 2003 10:11:43 +0000
From: Henrique Gobbi <henrique2.gobbi@cyclades.com>
Reply-To: henrique.gobbi@cyclades.com
Organization: Cyclades Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
Cc: henrique.gobbi@cyclades.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: cyclades region handling updates from 2.4
References: <200303241641.h2OGft35008188@deviant.impure.org.uk> <3E7ED5F6.9090301@cyclades.com> <20030324180211.GA8300@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > How extensively did you test it.
> 
> -ENOHARDWARE.
> 
>  > This driver is working and I don't wanna it broken. There are too many 
>  > customers counting on it.
> 
> if you have customers depending on 2.5 right now, you have bigger problems.
> Note this is only stuff that has already been merged into 2.4

No, there's no customers using 2.5. But there's a lot of them using 2.4. 
  Let's do like this. I'll test your patch and, if it works, Marcelo can 
merge it into the oficial 2.4.x tree.

regards
Henrique

