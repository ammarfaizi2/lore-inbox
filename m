Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWG3Hqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWG3Hqv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 03:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWG3Hqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 03:46:50 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:7614 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S1751277AbWG3Hqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 03:46:50 -0400
Message-ID: <44CC0161.60806@namesys.com>
Date: Sat, 29 Jul 2006 18:46:25 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Viro <viro@zeniv.linux.org.uk>,
       Al Viro <viro@ftp.linux.org.uk>, reiserfs-dev@namesys.com,
       reiserfs-list@namesys.com, akpm@osdl.org,
       Alexander Zarochentcev <zam@namesys.com>
Subject: Re: possible recursive locking detected - while running fs operations
 in loops - 2.6.18-rc2-git5
References: <9a8748490607251516j1433306ek9c64cc84c0838f7b@mail.gmail.com>	 <20060725232924.GU6452@schatzie.adilger.int>	 <9a8748490607291518m59573244wac00486a64f6385b@mail.gmail.com>	 <44CBEA7A.4010308@namesys.com> <9a8748490607292317t405c906ek8b1577920eeace65@mail.gmail.com>
In-Reply-To: <9a8748490607292317t405c906ek8b1577920eeace65@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

> On 30/07/06, Hans Reiser <reiser@namesys.com> wrote:
>
>> Jesper Juhl wrote:
>>
>> >
>> > Thanks. That's a nice little test suite.
>> >
>> Yes, it is quite useful, our developers have added it to the regression
>> suite....
>>
> That's nice.
>
> Now how about that lock validator message I managed to tease out?
>
> Akpm said "... the reiserfs locking appears to be unneeded - this inode
> is going down and nobody else can look it up, so what is to be locked
> against?" - can you comment on that?
>
>
Err, how about Zam handles all locking issues and this is Sunday with
the family?  I know, lame, but he'll answer you on Monday Russian
time.....;-)
