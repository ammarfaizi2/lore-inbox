Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289702AbSAJVlx>; Thu, 10 Jan 2002 16:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289703AbSAJVln>; Thu, 10 Jan 2002 16:41:43 -0500
Received: from freeside.toyota.com ([63.87.74.7]:22802 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S289702AbSAJVlf>; Thu, 10 Jan 2002 16:41:35 -0500
Message-ID: <3C3E0354.3000501@lexus.com>
Date: Thu, 10 Jan 2002 13:10:44 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: David Balazic <david.balazic@uni-mb.si>,
        matthias.andree@stud.uni-dortmund.de,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Simple local DOS
In-Reply-To: <Pine.LNX.3.95.1020110090502.5205A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nope, if the console is hosed that won't work.

That's when I use the magic sys rq keys -

cu

jjs

Richard B. Johnson wrote:

>On Thu, 10 Jan 2002, David Balazic wrote:
>
>>Matthias Andree (matthias.andree@stud.uni-dortmund.de) wrote :
>>
>>>On Wed, 09 Jan 2002, David Balazic wrote: 
>>>
>>>>log in on some virtual terminal, then run the following line 
>>>>in a bourne type shell, like bash : 
>>>>
>>>>X 2>&1 | less 
>>>>
>>>>A reboot "fixes" it. We want to reach windows level quality on desktop 
>>>>after all, don't we ? 
>>>>
>>>You can also fix that by a remote login,
>>>
>
>Ctrl-ALT-F12 selects VT mode from a locked X-window, ALT-F1 gets you
>to the first VT, ALT-F2, next, etc.
>No problem at all.
>
>
>Cheers,
>Dick Johnson
>
>Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).
>
>    I was going to compile a list of innovations that could be
>    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>    was handled in the BIOS, I found that there aren't any.
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


