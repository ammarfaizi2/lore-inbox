Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSJUHaJ>; Mon, 21 Oct 2002 03:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261211AbSJUHaF>; Mon, 21 Oct 2002 03:30:05 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:20234 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261205AbSJUHaD>; Mon, 21 Oct 2002 03:30:03 -0400
Message-Id: <200210210731.g9L7V8p21199@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: landley@trommello.org, linux-kernel@vger.kernel.org
Subject: Re: Crunch time -- Final merge candidates for 3.0 (the list).
Date: Mon, 21 Oct 2002 10:23:54 -0200
X-Mailer: KMail [version 1.3.2]
Cc: boissiere@nl.linux.org
References: <200210201849.23667.landley@trommello.org>
In-Reply-To: <200210201849.23667.landley@trommello.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 October 2002 21:49, Rob Landley wrote:
> When Linus comes back, at best he's going to give a thumbs up or
> thumbs down to each patch currently sitting there in front of him,
> and then it's on to the feature freeze.  He may not take any of them,
> or he may just take one or two.  But the best we can hope to do is
> present him with a nice (short) list of tested patches. (Remember,
> the less work Linus has to do, the higher the percentage of it that
> will actually get done.)

Well, maybe it makes sense to reduce flow of non-features patches
for a couple of days to let Linus feel less buried in email?
I think VM tweaking and such... It could be done after Linus
say what got in and what did not.

Although I doubt we can keep akpm/acme/davem/etc/etc/etc from hacking,
maybe there's a way to block SMTP traffic from them? ;)
(just kidding. They develop features as well)
--
vda
