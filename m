Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132870AbRDIXAZ>; Mon, 9 Apr 2001 19:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132871AbRDIXAQ>; Mon, 9 Apr 2001 19:00:16 -0400
Received: from james.kalifornia.com ([208.179.59.2]:9260 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S132870AbRDIXAK>; Mon, 9 Apr 2001 19:00:10 -0400
Message-ID: <3AD23E7A.5050105@blue-labs.org>
Date: Mon, 09 Apr 2001 15:58:02 -0700
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-pre8 i686; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: "Henning P. Schmiedehausen" <hps@intermeta.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: goodbye
In-Reply-To: <Pine.LNX.4.21.0104031800030.14090-100000@imladris.rielhome.conectiva> <986844003.21377.12.camel@mistress> <9at9sc$kva$1@forge.intermeta.de> <20010410012337.Z805@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
>> So, Mr. Admin, setup your laptop to use SSL to your SMTP and POP
>> server and authenticate with a client side certificate on your
>> laptop. Welcome to the 21st century. You may, however, need a little
>> more infrastructure than you can pull from your favourite distribution
>> box.
> 
> 
>         RFC 2487        STARTTLS
>         RFC 2554        SMTP-Auth, + M$ Exchange / + Netscape
>                         ( + a bunch of other authenticator methods )
> 
>         Under encryption, plaintext username + password login.
>         The IETF protocols DO NOT support plaintext login for
>         obvious security reasons.
> 
>         No hazzles about autenticating by certificates.
> 
>         Availability of the feature is probably excidingly rare..

Actually TLS/SASL is exactly what I use on my systems and I offer it to 
whomever needs it.  The way I do it is at 
http://blue-labs.org/clue/sendmail.html.

-d


