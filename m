Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281440AbRKUJOm>; Wed, 21 Nov 2001 04:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281497AbRKUJOd>; Wed, 21 Nov 2001 04:14:33 -0500
Received: from a59178.upc-a.chello.nl ([62.163.59.178]:60177 "EHLO
	www.unternet.org") by vger.kernel.org with ESMTP id <S281440AbRKUJOW>;
	Wed, 21 Nov 2001 04:14:22 -0500
Date: Wed, 21 Nov 2001 10:12:45 +0100
From: Frank de Lange <lkml-frank@unternet.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Frank de Lange <lkml-frank@unternet.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>,
        Chris Mason <mason@suse.com>
Subject: Re: Abysmal interactive performance on 2.4.linus
Message-ID: <20011121101245.A5454@unternet.org>
In-Reply-To: <20011112205551.A14132@unternet.org> <3BF02BA4.D7E2D70E@mandrakesoft.com> <20011112235642.A17544@unternet.org> <3BFB6B09.1060103@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BFB6B09.1060103@namesys.com>; from reiser@namesys.com on Wed, Nov 21, 2001 at 11:51:21AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2001 at 11:51:21AM +0300, Hans Reiser wrote:
> Yura, see if you can reproduce this and analyze the cause.  If I 
> understand correctly, he is saying the problem is not throughput but 
> latency.  Is that correct Frank?  Once Yura reproduces it, I will 
> speculate as to the cause.

Correct.

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \ lkml-frank@unternet.org  /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
