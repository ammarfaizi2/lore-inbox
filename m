Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSIPW3P>; Mon, 16 Sep 2002 18:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263254AbSIPW3P>; Mon, 16 Sep 2002 18:29:15 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:30470 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S263246AbSIPW3N>;
	Mon, 16 Sep 2002 18:29:13 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209162234.g8GMY2825694@oboe.it.uc3m.es>
Subject: tagged block requests
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Tue, 17 Sep 2002 00:34:02 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone point me to some documentation or an example
or give me a quick rundown on how I should use the new
tagged block request structure in 2.5.3x?

It looks like something I want. I've already tried issuing
"special" requests as (re)ordering barriers, and that works 
fine. How does the tag request interface fit in with that,
if it does?

Peter
