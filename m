Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132541AbRDHLvX>; Sun, 8 Apr 2001 07:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132546AbRDHLvN>; Sun, 8 Apr 2001 07:51:13 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:1494 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S132541AbRDHLvF>; Sun, 8 Apr 2001 07:51:05 -0400
From: kumon@flab.fujitsu.co.jp
Date: Sun, 8 Apr 2001 20:50:51 +0900
Message-Id: <200104081150.UAA24135@asami.proc.flab.fujitsu.co.jp>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: kumon@flab.fujitsu.co.jp, Michael Peddemors <michael@linuxmagic.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: goodbye
In-Reply-To: <20010408132205.O805@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.21.0104031800030.14090-100000@imladris.rielhome.conectiva>
	<20010404012102Z131724-406+7418@vger.kernel.org>
	<20010408023228.L805@mea-ext.zmailer.org>
	<200104080510.OAA23675@asami.proc.flab.fujitsu.co.jp>
	<20010408132205.O805@mea-ext.zmailer.org>
Reply-To: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio writes:
 > On Sun, Apr 08, 2001 at 02:10:52PM +0900, kumon@flab.fujitsu.co.jp wrote:
 > > How about creating an additional ML,
 > > the new ML (say LKML-DUL) is used to send mails from DUL to LKML, but
 > > such mails are not sent to LMKL.
 > 
 > 	Layering and technology problem.

It may or may not be possible using the current MTA implementation,
but I know you are one of the authors of zmailer, it is possible for you.

Layering problem can be solved by using two different sendmail configuration
files, one is for DUL and another is for non-DUL.

I don't intend you to do, however I think it can be solved by
technology.

--
Computer Systems Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
