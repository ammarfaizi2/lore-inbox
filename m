Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267413AbSLLDzY>; Wed, 11 Dec 2002 22:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267414AbSLLDzY>; Wed, 11 Dec 2002 22:55:24 -0500
Received: from mx1.visp.co.nz ([210.55.24.20]:15108 "EHLO mail.visp.co.nz")
	by vger.kernel.org with ESMTP id <S267413AbSLLDzY>;
	Wed, 11 Dec 2002 22:55:24 -0500
Subject: File still being accessed?
From: mdew <mdew@orcon.net.nz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 12 Dec 2002 17:03:06 +1300
Message-Id: <1039665790.602.5.camel@nirvana>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under Linux 2.5.51 Ive noticed that Downloader4X (Getright-type for
linux) http://www.krasu.ru/soft/chuchelo/

when trying to resume a file, It thinks the file is still being
accessed, however under 2.4, it has no such problem. Is this a bug in
2.5.x still? any patches available that could help?

thanks
-mdew

