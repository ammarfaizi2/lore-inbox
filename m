Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281691AbRKZNzd>; Mon, 26 Nov 2001 08:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281692AbRKZNzX>; Mon, 26 Nov 2001 08:55:23 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:41740 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S281691AbRKZNzJ>;
	Mon, 26 Nov 2001 08:55:09 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/802/Makefile 
In-Reply-To: Your message of "Mon, 26 Nov 2001 14:32:26 BST."
             <200111261332.fAQDWQF17920@ns.caldera.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Nov 2001 00:54:51 +1100
Message-ID: <2695.1006782891@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001 14:32:26 +0100, 
Christoph Hellwig <hch@ns.caldera.de> wrote:
>In article <20011126142425.B27554@suse.de> you wrote:
>> On Mon, Nov 26, Olaf Hering wrote:
>>> 
>>> the build stops when cl2llc.c has no write permissions.
>>
>> Here is a better version, suggested by Rik:
>
>What about just removing cl2llc.c from the tarball?

I was going to do that but AC said that all of net/802 was being
rewritten and removing cl2llc.c now would just be noise.  The file will
be removed in kbuild 2.5.

