Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932778AbVITRng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbVITRng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932779AbVITRng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:43:36 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:45803 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932778AbVITRnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:43:35 -0400
Message-ID: <43304A41.7080206@namesys.com>
Date: Tue, 20 Sep 2005 10:43:29 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Nikita Danilov <nikita@clusterfs.com>, stephen.pollei@gmail.com,
       Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509201536.j8KFa6wn011651@laptop11.inf.utfsm.cl>
In-Reply-To: <200509201536.j8KFa6wn011651@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>Nikita Danilov <nikita@clusterfs.com> wrote:
>  
>
>
>It is supposed to go into the kernel, which is not exactly warning-free.
>  
>
While I have no passionate feelings about Nikita's ifdef, I must note
that Reiser4 will always be warning free within 3 days of my finding out
that somebody left a warning in.;-)

I hate messy code.;-)

The rest of the kernel should be fixed to be warning free.

>Besides, you don't know what idiotic new warnings the gcc people might
>dream up the next round, so just relying on no warnings is extremely
>unwise.
>  
>
I find the above unconvincing.

Is that what this thread boils down to, that you guys think the compile
should fail not warn? 

>As was said before: It it is /really/ wrong, arrange for it not to compile
>or not to link. If it isn't, well... then it wasn't that wrong anyway.
>  
>

