Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSD1MAI>; Sun, 28 Apr 2002 08:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293680AbSD1MAH>; Sun, 28 Apr 2002 08:00:07 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:53466 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S293632AbSD1MAH>; Sun, 28 Apr 2002 08:00:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: "ChristianK."@t-online.de (Christian Koenig)
To: linux-kernel@vger.kernel.org
Subject: How far has initramfs got ?
Date: Sun, 28 Apr 2002 16:00:16 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <171nLP-1WyTImC@fwd09.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got some spare time to look at my all day problems / questions.

How far have the initramfs stuff got ? Is there any code yet ?
I have implementet some very very simple cpio image extraction in 
init/do_mounts.c and want to know if this could be usefull to somebody. 

Should it be possible to use initramfs without the ramdisk driver compiled in?

cu, Christian Koenig.
