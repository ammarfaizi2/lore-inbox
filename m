Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316113AbSFDDRP>; Mon, 3 Jun 2002 23:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316127AbSFDDRO>; Mon, 3 Jun 2002 23:17:14 -0400
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:44179 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S316113AbSFDDRO>;
	Mon, 3 Jun 2002 23:17:14 -0400
Message-ID: <3CFC3139.3080109@tmsusa.com>
Date: Mon, 03 Jun 2002 20:17:13 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020603
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt_Domsch@Dell.com
CC: matti.aarnio@zmailer.org, linux-kernel@vger.kernel.org
Subject: Re: please kindly get back to me
In-Reply-To: <9A2D9C0E5A442340BABEBE55D81BEBDB0120518A@AUSXMPS313.aus.amer.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt_Domsch@Dell.com wrote:

>I've been using SpamAssassin on lists.us.dell.com for a couple months now.
>It's pretty effective, but of course not perfect - maybe one a month gets
>through, though I'm dealing with less traffic than vger.  I'm not actually
>filtering linux-kernel-digest or -daily-digest, except to verify that the
>mail actually was sent from vger and not some spammer.  With procmail
>recipies, it works quite well.  
>
I have been honing a set of procmail rules,
but it's a fine balance between thorough
checks and excessive slowdown of the
mail thoughput -

Anybody used spam assasin for a domain
handling say a few million messages and
a few hundred GB of mail every month,
to say 12,000 users?

I'm looking for a  good tradeoff between
fairly good spam rejection, and keeping
the "fast path" from bogging down  -

Will I just have to bite the bullet and use
a pair of quad CPU monsters for mail
to get good throughput?

Joe
 


