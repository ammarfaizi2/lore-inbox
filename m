Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSD3XBJ>; Tue, 30 Apr 2002 19:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315262AbSD3XBI>; Tue, 30 Apr 2002 19:01:08 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:5772 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S315259AbSD3XBI>;
	Tue, 30 Apr 2002 19:01:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: linux-kernel@vger.kernel.org
Subject: Re: Combined low latency & performance patches for 2.4.18
Date: Wed, 1 May 2002 09:01:05 +1000
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020429142443.A62481333@pc.kolivas.net> <3CCD7A07.D661110E@compro.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020430230105.D5CA01A0AA@pc.kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2002 02:51, you wrote:
> After applying it, if you ever do a make mrproper oldconfig dep bzImage it
> fails to compile sched.c as follows

> If I don't  do an mrproper it compiles ok. Haven't tested yet.

Hmm
I used a make mrproper && make clean followed by manual configuration without 
any problems but thanks for your input. I'm not claiming to be a patch or 
kernel guru. Just offering what worked for me.

> It's the O1 sched patch. Not your fault....

Thanks thats kinda reassuring :)

Con.

