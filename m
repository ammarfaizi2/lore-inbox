Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292518AbSBTVhs>; Wed, 20 Feb 2002 16:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292521AbSBTVhi>; Wed, 20 Feb 2002 16:37:38 -0500
Received: from tomts12.bellnexxia.net ([209.226.175.56]:32648 "EHLO
	tomts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S292519AbSBTVhZ>; Wed, 20 Feb 2002 16:37:25 -0500
Date: Wed, 20 Feb 2002 16:36:57 -0800
From: Jason Yan <jasonyanjk@yahoo.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re:initialize page tables --  Re: paging question
X-mailer: FoxMail 4.0 beta 2 [cn]
Message-Id: <20020220213724.SKHN4996.tomts12-srv.bellnexxia.net@abc337>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all.

OK. I got it. and,

Is the linker who set the beginning virtual address as 0xc0100000 ? Is it a must? When and where? at the time "make bzImage" ?  If it's not a BIG kernel, is the magic number still 0xc0100000 ?

Thanks,

Jason




