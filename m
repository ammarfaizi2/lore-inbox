Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263988AbSIUAHf>; Fri, 20 Sep 2002 20:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275172AbSIUAHf>; Fri, 20 Sep 2002 20:07:35 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:50596 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263988AbSIUAHe> convert rfc822-to-8bit; Fri, 20 Sep 2002 20:07:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20-pre7-ac3{-rmap14b|-preempt}
Date: Sat, 21 Sep 2002 02:12:19 +0200
X-Mailer: KMail [version 1.4]
References: <200209210125.01953.m.c.p@wolk-project.de>
In-Reply-To: <200209210125.01953.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209210212.19775.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 September 2002 02:02, you wrote:

Hi there,

> -----------------------------------------------------------
> NOTE: Apply the rmap14b patch first and then preempt ontop!
> -----------------------------------------------------------
totally bullshit ;( ... Sorry. Ok, follow like this:

1. if you only want rmap14b, apply rmap14b patch
2. if you want both, rmap14b and preempt, apply rmap14b-preempt patch

Now it's right :) ... Sorry!

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
