Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284644AbRLET64>; Wed, 5 Dec 2001 14:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284649AbRLET6r>; Wed, 5 Dec 2001 14:58:47 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:48144 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284643AbRLET6g>; Wed, 5 Dec 2001 14:58:36 -0500
Date: Wed, 5 Dec 2001 16:41:42 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.17-pre4
Message-ID: <Pine.LNX.4.21.0112051640570.20575-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Duh. I forgot to add tcp_diag.c and tcp_diag.h in -pre3, which avoid it to
compile correctly.

Well, here goes -pre4 which fixes that.

- Added missing tcp_diag.c and tcp_diag.h       (me)

