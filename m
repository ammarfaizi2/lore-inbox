Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751584AbWFUOXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbWFUOXZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWFUOXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:23:25 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:48553 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751449AbWFUOXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:23:24 -0400
Date: Wed, 21 Jun 2006 16:18:04 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: gcc-4.1.1 and kernel-2.4.32
In-Reply-To: <200606211317.k5LDHYLv012510@wildsau.enemy.org>
Message-ID: <Pine.LNX.4.61.0606211615390.31302@yvahk01.tjqt.qr>
References: <200606211317.k5LDHYLv012510@wildsau.enemy.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>good day,
>
>trying to compile 2.4.32 with gcc-4.1.1 (probably any 4.x gcc?) produces
>a lot of errors, (i.e., declaration of symbols of different types and so on).
>
>I wonder if it is planned to be fixed? No idea who's maintaining it - 
>in case you want to, I could send you diffs to make 2.4.32 compile.
>
In effect (mainline) no. Linux 2.2 and 2.0 won't be fixed for the same 
reason; called deep maintenance. 2.6 has been on the road since Dec 2003, 
that's over 2 years. Do away with the old stuff.


Jan Engelhardt
-- 
