Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281680AbRKZNrx>; Mon, 26 Nov 2001 08:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281681AbRKZNro>; Mon, 26 Nov 2001 08:47:44 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:23308 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281680AbRKZNra>; Mon, 26 Nov 2001 08:47:30 -0500
Date: Mon, 26 Nov 2001 10:30:08 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, editors@newsforge.com,
        lwn@lwn.net
Subject: Linux 2.4.16 
Message-ID: <Pine.LNX.4.21.0111261003070.13400-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Due to the corruption problems on 2.4.15, I'm releasing 2.4.16.


Changelog: 

final:

- Fix 8139too oops				(Philipp Matthias Hahn)

pre1:
- Correctly sync inodes in iput()                          (Alexander Viro)
- Make pagecache readahead size tunable via /proc          (was in -ac tree)
- Fix PPC kernel compilation problems                      (Paul Mackerras)


