Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSHXAtO>; Fri, 23 Aug 2002 20:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSHXAtO>; Fri, 23 Aug 2002 20:49:14 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:30394 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S314548AbSHXAtO>;
	Fri, 23 Aug 2002 20:49:14 -0400
Message-ID: <1030150403.3d66d90381ae0@kolivas.net>
Date: Sat, 24 Aug 2002 10:53:23 +1000
From: conman@kolivas.net
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: Combined performance patches update for 2.4.19
References: <20020823233128.20631.qmail@linuxmail.org>
In-Reply-To: <20020823233128.20631.qmail@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paolo Ciarrocchi <ciarrocchi@linuxmail.org>:

> Hi Kon, 
> I've just tried your patch with a fresh 2.4.19.
> here it goes the dmesg output,
> there is something wrong with preempt:
> 
> note: consoletype[499] exited with preempt_count 1

Yes if you read my FAQ you'd see this is a known issue. I need some higher help
to sort this out

> BTW, thank you for your great work!!

My pleasure, but really the hard work is done by the developers!

> I'm also testing the compressed cache (the 
> patch you've discarded, and I got good performance!)

I'm thinking of eventually merging the latest version of this into 2.4.19 too
since it can be enabled or disabled. Depends on the demand.

Con.


