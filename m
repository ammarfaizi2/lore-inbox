Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbTBJW0P>; Mon, 10 Feb 2003 17:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265484AbTBJW0O>; Mon, 10 Feb 2003 17:26:14 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:44111 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id <S265480AbTBJW0N>; Mon, 10 Feb 2003 17:26:13 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Jos Hulzink <josh@stack.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.60] : drivers/video/clgenfb.c compile error
Date: Mon, 10 Feb 2003 23:35:53 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200302102335.53302.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

drivers/video/clgenfb.c doesn't compile, for hundreds of things are undefined...

seems the include/video/fbdev*.h files are missing in the ftp.kernel.org 2.5.60 ?

Jos
