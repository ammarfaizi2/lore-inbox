Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbSKMUjh>; Wed, 13 Nov 2002 15:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbSKMUjh>; Wed, 13 Nov 2002 15:39:37 -0500
Received: from alpha.ek3.com ([129.100.142.170]:49934 "EHLO alpha.ek3.com")
	by vger.kernel.org with ESMTP id <S262806AbSKMUjg>;
	Wed, 13 Nov 2002 15:39:36 -0500
Message-ID: <3FF2458E5C16B44AA6807F990CBE63DA04983A@alpha.ek3.com>
From: Dan Steele <dan@EK3.com>
To: "'Pavel Machek'" <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: RE: loop no longer works in 2.5.47?
Date: Wed, 13 Nov 2002 15:38:55 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi!
>
>I tried to loop-mount ext2 filesystem, and it seems to no longer work:
>
>Buffer I/O error on device loop(7,0), logical block 0
Someone posted a patch a couple days ago for that.

Dan.
