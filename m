Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284610AbRLXKet>; Mon, 24 Dec 2001 05:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284612AbRLXKe3>; Mon, 24 Dec 2001 05:34:29 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:28174 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S284610AbRLXKeR>; Mon, 24 Dec 2001 05:34:17 -0500
Message-ID: <3C270429.8010103@namesys.com>
Date: Mon, 24 Dec 2001 13:32:09 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: bil Jeschke <theuteck@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reaiser fs
In-Reply-To: <20011224040036.52568.qmail@web20106.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bil Jeschke wrote:

>Ooops, i figured out what went wrong, but if I have to
>enable the experimental drivers, of which Reiser is
>not, then why is ext3 a choice when it is labeled
>experimental and I did not enable the experimental drivers?
>
>__________________________________________________
>Do You Yahoo!?
>Send your FREE holiday greetings online!
>http://greetings.yahoo.com
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
ReiserFS is not labelled experimental in the SuSE kernel nowadays...... 
  and I think SuSE is correct.  We still have bugs, you can read about 
them on our mailing list, but hitting them is much less likely than a 
drive failure for ReiserFS users on the whole.  2.4.17 looks like our 
most stable version yet.  Marcello does a really nice job of quickly 
integrating patches.

Hans


