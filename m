Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317538AbSGOP7u>; Mon, 15 Jul 2002 11:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317539AbSGOP7t>; Mon, 15 Jul 2002 11:59:49 -0400
Received: from [194.202.59.31] ([194.202.59.31]:51473 "EHLO
	tempest.chil.ndsuk.com") by vger.kernel.org with ESMTP
	id <S317538AbSGOP7s>; Mon, 15 Jul 2002 11:59:48 -0400
Message-ID: <1A961872F9CE0B4AB641DD256115865F225C5E@tornado.uk.nds.com>
From: "Weber, Frank" <FWeber@ndsuk.com>
To: linux-kernel@vger.kernel.org
Subject: Process-wise swap-on/off option
Date: Mon, 15 Jul 2002 17:01:00 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

Is it possible to arrange that a Linux application 
(or one of its threads) has the ability to

	"... lock (a certain) stack and data segment ... 
	into memory so that it can't be swapped out"?

[This has been formulated as a requirement by one of 
our analysts.]

I have been told that this is unlikely (except by 
disabling swapout altogether (for all processes). 

Any hints as to where to look for a solution (i.e., 
pointers to documentation or manuals where the ifs 
and hows are explained) would be greatly appreciated.

Many thanks in advance,
F.P.Weber


P.S. Due to security on our mail-server i am unable to
enrol or subscribe to the news-group. Please cc me into
any replies. Thanks again.
