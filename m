Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbTBJUqs>; Mon, 10 Feb 2003 15:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbTBJUqs>; Mon, 10 Feb 2003 15:46:48 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.222]:52982 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S262871AbTBJUqs>; Mon, 10 Feb 2003 15:46:48 -0500
Date: Mon, 10 Feb 2003 16:06:48 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: 2.5.60 : fs/ncpfs/sock.c compile error
Message-ID: <Pine.LNX.4.44.0302101605120.9231-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  While compiling 2.5.60, I received the following error.
Regards,
Frank

fs/ncpfs/sock.c: In function `ncp_do_request':
fs/ncpfs/sock.c:760: structure has no member named `sig'
fs/ncpfs/sock.c:762: structure has no member named `sig'
make[2]: *** [fs/ncpfs/sock.o] Error 1
make[1]: *** [fs/ncpfs] Error 2
make: *** [fs] Error 2




