Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318121AbSHDHze>; Sun, 4 Aug 2002 03:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318122AbSHDHze>; Sun, 4 Aug 2002 03:55:34 -0400
Received: from smtp01.web.de ([194.45.170.210]:40486 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S318121AbSHDHze>;
	Sun, 4 Aug 2002 03:55:34 -0400
Subject: Re: RE:2.4.19 warnings with allnoconfig
From: Christian Neumair <christian-neumair@web.de>
To: Hell.Surfers@cwctv.net
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <0ab2d4837030482DTVMAIL12@smtp.cwctv.net>
References: <0ab2d4837030482DTVMAIL12@smtp.cwctv.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Aug 2002 09:58:25 +0200
Message-Id: <1028447908.4339.3.camel@kellerbar.lan.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.19 with make allnoconfig produces these warnings.

Just a hint:
There is almost no software with completely clean code.
Whenever you see one compiling and it produces no warnings it's most
likely that the build script just suppresses warnings.

see you,
 Chris

