Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318128AbSHZQ4Z>; Mon, 26 Aug 2002 12:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318131AbSHZQ4Z>; Mon, 26 Aug 2002 12:56:25 -0400
Received: from web40210.mail.yahoo.com ([66.218.78.71]:39480 "HELO
	web40210.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318128AbSHZQ4Z>; Mon, 26 Aug 2002 12:56:25 -0400
Message-ID: <20020826170037.69164.qmail@web40210.mail.yahoo.com>
Date: Mon, 26 Aug 2002 10:00:37 -0700 (PDT)
From: mike heffner <mdheffner@yahoo.com>
Subject: Re: PROBLEM:  conflict between apm and system clock on Inspiron 8100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1030355753.16767.35.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> The 8100 seems to turn off interrupts itself and
> read the battery very
> slowly causing lost ticks (its taking > 1/100th of a
> second to do the
> read). 

Well, isn't that a nice feature.  Is there a
workaround for this hardware?

Thanks
Mike

__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
