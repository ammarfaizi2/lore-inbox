Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292404AbSBPQWQ>; Sat, 16 Feb 2002 11:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292405AbSBPQWG>; Sat, 16 Feb 2002 11:22:06 -0500
Received: from [212.16.7.66] ([212.16.7.66]:48650 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S292404AbSBPQVv>;
	Sat, 16 Feb 2002 11:21:51 -0500
Message-ID: <3C6E08FB.7030308@namesys.com>
Date: Sat, 16 Feb 2002 10:23:39 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Anish Srivastava <anish@bidorbuyindia.com>, linux-kernel@vger.kernel.org,
        edward@thebsh.namesys.com
Subject: Re: File BlockSize
In-Reply-To: <002e01c1b397$1a26d270$3c00a8c0@baazee.com> <20020212075203.GF767@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>On Tue, Feb 12, 2002 at 01:00:07PM +0530, Anish Srivastava wrote:
>
>>Hi!!
>>Is there any way I can have 8K block sizes in ext2, reiserfs or ext3.
>>I am trying to install Oracle on Linux with 8K DB_Block_size.
>>But it gives me a Block size mismatch saying that the File BlockSize is only
>>4K
>>Maybe, there is a kernel patch available which enables Linux to create 8K
>>file blocks.
>>Thanks in anticipation....
>>
>
>Unfortunately filesystem block sizes larger than PAGE_SIZE are unsupported.
>I wish they were, though.
>
>Cheers,
>Bill
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
I should be more precise, on alpha you can do it with reiserfs.

Hans


