Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261625AbSIXJhN>; Tue, 24 Sep 2002 05:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261623AbSIXJhM>; Tue, 24 Sep 2002 05:37:12 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:12809 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261625AbSIXJhM>; Tue, 24 Sep 2002 05:37:12 -0400
Message-ID: <3D903381.2030605@namesys.com>
Date: Tue, 24 Sep 2002 13:42:25 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jakob Oestergaard <jakob@unthought.net>
CC: Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS buglet
References: <20020924072455.GE2442@unthought.net> <20020924132110.A22362@namesys.com> <20020924092720.GF2442@unthought.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Oestergaard wrote:

>  
>
>You presume wrong.
>
>I posted to LKML about a month ago with some questions regarding exactly
>this issue.  I had a disk that worked on 128 byte atomic writes - a
>standard IDE disk.
>
>The conclusion was something like "we know jack about the disk's
>internal logic" so we need consistency measures instead of relying on
>anything from the disk.
>
>  
>
What was the model and brand?


