Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266537AbSLJDHC>; Mon, 9 Dec 2002 22:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbSLJDHC>; Mon, 9 Dec 2002 22:07:02 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:55204 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266537AbSLJDHB> convert rfc822-to-8bit; Mon, 9 Dec 2002 22:07:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH 2.4] IP: disable ECN support by default - Config option
Date: Tue, 10 Dec 2002 04:14:26 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
References: <200212100316.59910.m.c.p@wolk-project.de> <1039490901.18047.1.camel@rth.ninka.net>
In-Reply-To: <1039490901.18047.1.camel@rth.ninka.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212100413.45487.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 December 2002 04:28, David S. Miller wrote:

Hi David,

> CONFIG_INET_ECN does exactly what you want.
>
> If you turn it on, ECN is on by default.
> If you turn it off, ECN is off by default.

args, you are right. Sorry, my mistake! Maybe I need some sleep, looking twice 
it is sooo obvious :)

ciao, Marc
