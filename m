Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261388AbSJUOGE>; Mon, 21 Oct 2002 10:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbSJUOGE>; Mon, 21 Oct 2002 10:06:04 -0400
Received: from rakshak.ishoni.co.in ([164.164.83.140]:25550 "EHLO
	arianne.in.ishoni.com") by vger.kernel.org with ESMTP
	id <S261388AbSJUOGD>; Mon, 21 Oct 2002 10:06:03 -0400
Subject: gzip compression of vmlinux
From: Amol Kumar Lad <amolk@ishoni.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 21 Oct 2002 19:41:44 -0400
Message-Id: <1035243705.2202.3.camel@amol.in.ishoni.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 Currently we use gzip to compress vmlinux ( and finally form bzImage).
I am planning to replace it with bzip2 . Should I go ahead with it ?
Will it find its place in the latest kernel ? 
We save some 35k of compressed bzImage using bzip2

Please cc me

Thanks
Amol




