Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268732AbTBZMie>; Wed, 26 Feb 2003 07:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268734AbTBZMid>; Wed, 26 Feb 2003 07:38:33 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:57486 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S268732AbTBZMid>; Wed, 26 Feb 2003 07:38:33 -0500
Message-Id: <200302261248.h1QCmbGi003904@locutus.cmf.nrl.navy.mil>
To: Duncan Sands <baldrick@wanadoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] remove mod_inc_use_count from lec 
In-reply-to: Your message of "Wed, 26 Feb 2003 13:42:19 +0100."
             <200302261342.20282.baldrick@wanadoo.fr> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 26 Feb 2003 07:48:37 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200302261342.20282.baldrick@wanadoo.fr>,Duncan Sands writes:
>Woah!  Shouldn't you add some try_module_get calls in the atm device handling 
>routines first?

yeah someone pointed this out already -- working on it.
