Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313486AbSDJSU1>; Wed, 10 Apr 2002 14:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313487AbSDJSU1>; Wed, 10 Apr 2002 14:20:27 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:63670 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S313486AbSDJSUZ>; Wed, 10 Apr 2002 14:20:25 -0400
Message-ID: <3CB4824D.2030509@antefacto.com>
Date: Wed, 10 Apr 2002 19:19:57 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: timk@advfn.com
CC: linux-kernel@vger.kernel.org
Subject: Re: R/W compressed fs support??
In-Reply-To: <200204101306.g3AD67s01683@mail.advfn.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

e2compr for 2.4 is being implemented by alcatel (France).
I've successfully used it with 2.4.16 (against filesystems
created with the 2.2 version). although I haven't stressed
it yet. "Denis Richard" <dri@sxb.bsf.alcatel.fr> should
have more info (and the 769777 byte patch).

Padraig.

Tim Kay wrote:
> Hello,
> 	Does anyone know of a Linux equivalent to DoubleSpace or whatever that 
> allows you read and _write_ to a compressed partiton or filesystem (in a way 
> that is transparent to the progs using the fs). I know there was e2compr but 
> that doesn't seem to have been touched in nearly 2 years, and is 2.2 
> specific, Infotec and the CBD patch seem to have died and zlibc seems to be a 
> read only solution. I'd have thought this would have been a biggie for 
> embedded device people but there doesn't seem to be anything out there. 
> 
> 	Any pointers greatfully received....
> 
> T.I.A.
> 
> Tim


