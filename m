Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284422AbRLDBCY>; Mon, 3 Dec 2001 20:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279952AbRLDA7s>; Mon, 3 Dec 2001 19:59:48 -0500
Received: from smtp-rt-2.wanadoo.fr ([193.252.19.154]:11941 "EHLO
	apeiba.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S282175AbRLDA6y>; Mon, 3 Dec 2001 19:58:54 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ethan <Ethan@stinkfoot.org>, <linux-kernel@vger.kernel.org>
Cc: <paulus@samba.org>
Subject: Re: PPC kernel fails when IDE built as modules
Date: Tue, 4 Dec 2001 01:59:15 +0100
Message-Id: <20011204005915.4996@smtp.wanadoo.fr>
In-Reply-To: <20011204004457.6930@smtp.wanadoo.fr>
In-Reply-To: <20011204004457.6930@smtp.wanadoo.fr>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Just thought I'd drop a note that recent kernel builds (2.4.17-pre1,2) 
>>on PPC fail when IDE is built as modules.
>
>The fix for this is part of the big pmac merge I'm about to start
>with Marcelo. In the meantime, use the bitkeeper PPC tree
>(see http://www.penguinppc.org/dev/kernel.shtml for details).

Hrm.. Sorry, it looks like you indeed have a good point here.

I'll see how we can fix that tomorrow.

Ben.


