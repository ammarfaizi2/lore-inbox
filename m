Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbSLINQE>; Mon, 9 Dec 2002 08:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbSLINQD>; Mon, 9 Dec 2002 08:16:03 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:38113 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S265385AbSLINQD> convert rfc822-to-8bit;
	Mon, 9 Dec 2002 08:16:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: BUG in 2.5.50
Date: Mon, 9 Dec 2002 14:23:40 +0100
User-Agent: KMail/1.4.1
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200212091056.08860.roy@karlsbakk.net> <200212091236.06966.roy@karlsbakk.net> <Pine.LNX.4.50.0212090820250.2139-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0212090820250.2139-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212091423.40700.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 December 2002 14:21, Zwane Mwaikambo wrote:
> On Mon, 9 Dec 2002, Roy Sigurd Karlsbakk wrote:
> > > Is this reproducible? If so without CONFIG_PREEMPT?
> >
> > I found it easily reproducable - I just did the same old 'make
> > modules_install' from the kernel dir, and BUG. Witout CONFIG_PREEMPT,
> > however, I was not, and I tried to stress it quite a bit
>
> Unfortunately for you this currently falls under unsupported
> configuration.

What's unsupported of it? And then - why do menuconfig allow me to enable both 
TCQ and PREEMPT?

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

