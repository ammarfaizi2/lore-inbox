Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261596AbRERW4h>; Fri, 18 May 2001 18:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261597AbRERW41>; Fri, 18 May 2001 18:56:27 -0400
Received: from idiom.com ([216.240.32.1]:40973 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S261596AbRERW4S>;
	Fri, 18 May 2001 18:56:18 -0400
Message-ID: <3B05A86F.96E380DC@namesys.com>
Date: Fri, 18 May 2001 15:55:43 -0700
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Samium Gromoff <_deepfire@mail.ru>
CC: "Vladimir V. Saveliev" <monstr@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS 2.4.4/3.x.0k-pre2
In-Reply-To: <E14zc0K-0000ya-00@f6.mail.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samium Gromoff wrote:
> 
>           Hello,
>      I`m still experiencing file tail corruptions
>   on subj.
>      And more: after i had restored bblocked patrition
>   (by relying on drive`s ability to remap bblks on
>   write by wroting small modification of debugreiserfs
>   which zeroified all bblks), i had _runtime_ tail
>    corruptions of the mc`s dir hotlist which i tried
>    to rewrite again and again.
>   i found, that "sync"ing after modifying helps to keep
>   file fine, so it does until now.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
we would be very eager to receive any testing method that could incurr tail
corruption on a disk drive other than the one that you have that is known
unreliable.


Hans
