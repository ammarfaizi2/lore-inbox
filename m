Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261412AbTCYDvz>; Mon, 24 Mar 2003 22:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261432AbTCYDvz>; Mon, 24 Mar 2003 22:51:55 -0500
Received: from mail140.mail.bellsouth.net ([205.152.58.100]:20748 "EHLO
	imf52bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S261412AbTCYDvy>; Mon, 24 Mar 2003 22:51:54 -0500
Subject: 2.5 and modules ?
From: Louis Garcia <louisg00@bellsouth.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1048564993.2994.13.camel@tiger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 24 Mar 2003 23:03:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just installed 2.5.6x on my RH phoebe box and everything is working
except modules. I recompiled the modutils package with module-init-tools
according to rusty's old modutils package spec. I am able to compile 2.5
as modules without any depmod errors but when I boot 2.5 I can't load
any.

--Lou

