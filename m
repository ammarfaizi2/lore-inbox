Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317341AbSIIPro>; Mon, 9 Sep 2002 11:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSIIPro>; Mon, 9 Sep 2002 11:47:44 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:13322 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S317341AbSIIPrn>; Mon, 9 Sep 2002 11:47:43 -0400
Message-ID: <3D7CC3BA.2040201@namesys.com>
Date: Mon, 09 Sep 2002 19:52:26 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: green@namesys.com, linux-kernel@vger.kernel.org, flx@thebsh.namesys.com
Subject: Re: [BK] PATCH ReiserFS 1 of 3 RESEND
References: <Pine.LNX.4.44.0209090831240.1641-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your suggestion, we will act on it and do so.

Hans

Linus Torvalds wrote:

>Hans,
> one of the reasons for problems with your patches is that your emails 
>seem to sometimes be labeled as spam.
>
>And one of the major reasons for that is apparently simply that your 
>"From:" address is not a good one:
>
>	From: reiser@reload.namesys.com (Hans Reiser)
>
>where "reload.namesys.com" is not in the MX domain:
>
>	dig -t MX reload.namesys.com
>
>gives no answer. As a result, spam detectors look at the From: line and 
>consider you an extremely suspect person, likely to be up to no good.
>
>I would suggest you fix your mailer to have a valid MX-record return 
>address, ie <reiser@namesys.com> instead of <reiser@reload.namesys.com>.
>
>(Yes, I realize that both addresses likely work perfectly fine, and that
>"reload"  is the machine you actually use for sending the email, but
>still.. I bet I'm not the only one who uses spam filtering software that
>cares about issues like this.)
>
>[ Cc to linux-kernel left intact not to publicly castigate Hans, but 
>  because I know this is true for some other people too. ]
>
>			Linus
>
>
>
>  
>

