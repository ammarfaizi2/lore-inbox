Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbVIURfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVIURfB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVIURfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:35:01 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:62401 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751301AbVIURfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:35:00 -0400
Message-ID: <433199C0.3070806@namesys.com>
Date: Wed, 21 Sep 2005 10:34:56 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: stephen.pollei@gmail.com, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509201536.j8KFa6wn011651@laptop11.inf.utfsm.cl>	<43304A41.7080206@namesys.com>	<feed8cdd050920150866e7925d@mail.gmail.com>	<4330A783.9090405@namesys.com> <17201.14899.683012.997417@gargle.gargle.HOWL>
In-Reply-To: <17201.14899.683012.997417@gargle.gargle.HOWL>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Hans Reiser writes:
> > Stephen Pollei wrote:
> > 
> > >
> > >
> > >Also note my opinion, doesn't really count if you grep the kernel
> > >sources for pollei, you won't find anything.
> > >
> > >  
> > >
> > Your opinion counts, but lets see what Nikita says before I say
> > anything.  Nikita is more expert than I in regards to compiler tricks.
>
>That sort of guards was useful early in reiser4 debugging, when a lot of
>checks and assertions was  added (specifically, because reiser4 has many
>levels of debugging), but I am not sure source code clutter is justified
>now.
>
>Nikita.
>
>
>  
>
So what do you suggest we change it to, Nikita?
