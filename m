Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263120AbRE1TDz>; Mon, 28 May 2001 15:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263122AbRE1TDf>; Mon, 28 May 2001 15:03:35 -0400
Received: from sncgw.nai.com ([161.69.248.229]:40082 "HELO mcafee-labs.nai.com")
	by vger.kernel.org with SMTP id <S263120AbRE1TDd>;
	Mon, 28 May 2001 15:03:33 -0400
Message-ID: <XFMail.20010528120635.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010528113446.G32600@thune.mrc-home.com>
Date: Mon, 28 May 2001 12:06:35 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Mike Castle <dalgoda@ix.netcom.com>
Subject: Re: File read.
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28-May-2001 Mike Castle wrote:
> On Mon, May 28, 2001 at 11:26:31AM -0700, Davide Libenzi wrote:
>> 
>> On 28-Jun-2001 Anil Kumar wrote:
>> > hi,
>> > How do i read file within the kernel modules. I hope we can't use the FS
>> > open... calls within kernel.
>> 
>> You can access fs methods directly.
> 
> But generally you don't want to.

I usually don't but, you know, usually people like to know that they could ...




- Davide

