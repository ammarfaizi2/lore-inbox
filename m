Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316390AbSGAS4L>; Mon, 1 Jul 2002 14:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316397AbSGAS4K>; Mon, 1 Jul 2002 14:56:10 -0400
Received: from dingo.clsp.jhu.edu ([128.220.34.67]:24584 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S316390AbSGAS4J>;
	Mon, 1 Jul 2002 14:56:09 -0400
Date: Mon, 1 Jul 2002 04:30:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Salvatore D'Angelo" <dangelo.sasaman@tiscalinet.it>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Chris McDonald <chris@cs.uwa.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
Message-ID: <20020701023051.GE829@elf.ucw.cz>
References: <3D16DE83.3060409@tiscalinet.it> <200206240934.g5O9YL524660@budgie.cs.uwa.edu.au> <3D16F252.90309@tiscalinet.it> <20020624154620.P19520@mea-ext.zmailer.org> <3D172543.9070709@tiscalinet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D172543.9070709@tiscalinet.it>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On 2000000 call -> 189 times I found the problem (0.00945%)
> On 20000000 call ->1956 found I found the problem (0.00978%)
> 
> Probably you're right my previous percentage is too high (the one above 
> should be the correct one).
> 
> But do you think that this behaviour is normal?

Buggy hardware and kernel that is not able to work around that. Try
googling or asking vojtech pavlik, there should be patches to fix
this.

What chipset?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
