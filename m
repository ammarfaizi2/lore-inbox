Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316623AbSFJEnB>; Mon, 10 Jun 2002 00:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316629AbSFJEnA>; Mon, 10 Jun 2002 00:43:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52661 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316623AbSFJEnA>;
	Mon, 10 Jun 2002 00:43:00 -0400
Date: Sun, 09 Jun 2002 21:39:04 -0700 (PDT)
Message-Id: <20020609.213904.09568104.davem@redhat.com>
To: engler@csl.Stanford.EDU
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 18 potential missing unlocks in 2.4.17
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206100354.UAA17008@csl.Stanford.EDU>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.17 is _REALLY_ old, any chance you can rerun these things
on 2.4.19-pre10 by chance?

You should really investigate toning down the amount of hand frobbing
you have to do to the kernel tree to get your experimental g++ to eat
it.
