Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSLZGAY>; Thu, 26 Dec 2002 01:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbSLZGAY>; Thu, 26 Dec 2002 01:00:24 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:40716 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S261854AbSLZGAX> convert rfc822-to-8bit; Thu, 26 Dec 2002 01:00:23 -0500
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'Josh Brooks'" <user@mail.econolodgetulsa.com>,
       "'Ro0tSiEgE'" <lkml@ro0tsiege.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: CPU failures ... or something else ?
Date: Thu, 26 Dec 2002 00:08:36 -0600
Message-ID: <001c01c2aca5$3b9de4e0$b9293a41@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <20021225192051.R6873-100000@mail.econolodgetulsa.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I thought it was significant that I am
> running 2.4.1 on _identical_ hardware
> without problems - presumably if that
> is the case then running 2.4.16 on the
> same hardware should be fine as well
> (in terms of a buggy board) - therefore
> I suspect bad hardware.
>
> Is this good reasoning?

ABSOLUTELY NOT! I've been monitoring this list long enough to know that bug
HAVE BEEN INTRODUCED IN NEWER KERNEL VERSION that make things that worked in
older versions not work in new versions.

Run 2.4.20 and if you still have problems then try that one guy's advice who
said to disable Machine Check Exceptions.

Joseph Wagner

