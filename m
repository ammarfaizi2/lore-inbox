Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281392AbRKLKQ1>; Mon, 12 Nov 2001 05:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281395AbRKLKQR>; Mon, 12 Nov 2001 05:16:17 -0500
Received: from s1.relay.oleane.net ([195.25.12.48]:62387 "HELO
	s1.relay.oleane.net") by vger.kernel.org with SMTP
	id <S281394AbRKLKQL>; Mon, 12 Nov 2001 05:16:11 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: HFS Filesystem
Date: Mon, 12 Nov 2001 11:15:56 +0100
Message-Id: <20011112101556.20952@smtp.adsl.oleane.com>
In-Reply-To: <E163CqK-00057r-00@the-village.bc.nu>
In-Reply-To: <E163CqK-00057r-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>netatalk uses its own resource fork magic using .AppleDouble directories
>or a few other configurable formats. HFS on 2.2 also supports the same
>format so magically you can get real fork access
>
>For 2.4 the HFS code still needs some serious cleanup, and for 2.5 I suspect
>either someone fixes the locking on or it gets deleted

I've started reworking the locking but well... got distracted and never
finished.

It's on my list of things to do asap though.

Ben. 



