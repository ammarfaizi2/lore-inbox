Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWD1LDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWD1LDW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 07:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbWD1LDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 07:03:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37343 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964946AbWD1LDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 07:03:21 -0400
Date: Fri, 28 Apr 2006 13:03:20 +0200
From: Martin Mares <mj@ucw.cz>
To: Avi Kivity <avi@argo.co.il>
Cc: Davi Arnaut <davi.lkml@gmail.com>, Willy Tarreau <willy@w.ods.org>,
       Denis Vlasenko <vda@ilport.com.ua>, dtor_core@ameritech.net,
       Kyle Moffett <mrmacman_g4@mac.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
Message-ID: <mj+md-20060428.105455.7620.atrey@ucw.cz>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com> <444E61FD.7070408@argo.co.il> <200604271810.07575.vda@ilport.com.ua> <20060427201531.GH13027@w.ods.org> <750c918d0604271408y2afef6fflf380e4d0a6c1cec6@mail.gmail.com> <4451E185.9030107@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4451E185.9030107@argo.co.il>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> FWIW, userspace is moving away from C as unproductive and unsafe. KDE is 
> of course C++, mozilla, openoffice are C++, and gnome is moving towards 
> (of all things) C#.

Maybe continuing to write application programs in C instead of using
higher-level languages is silly and backward, but _stopping_ at the
level of C++ or C# is equally silly.

However, in the kernel space the main problems the people are spending
their time with are rarely related to the language.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Q: Do you believe in One God? A: Yes, up to isomorphism.
