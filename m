Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270240AbRH1EXC>; Tue, 28 Aug 2001 00:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270253AbRH1EWw>; Tue, 28 Aug 2001 00:22:52 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:21769 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S270240AbRH1EWf>; Tue, 28 Aug 2001 00:22:35 -0400
Date: Mon, 27 Aug 2001 23:54:54 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org
Subject: Testers needed for 2.4 highmem IO
Message-ID: <Pine.LNX.4.21.0108272344140.7602-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I need people with access to highmem machines (8GB or more) to test a
patch which should fix the current allocation failure problems under IO
stress with 2.4.10pre1.

Just stress the IO subsystem with huge amounts of data ( > 2x amount of
memory). Several threads doing the IO is preferred.

Patch at
http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.10pre1/highio.patch

Thanks!

