Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276522AbRJCQvq>; Wed, 3 Oct 2001 12:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276523AbRJCQv1>; Wed, 3 Oct 2001 12:51:27 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:42509 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S276522AbRJCQvS>; Wed, 3 Oct 2001 12:51:18 -0400
Date: Wed, 3 Oct 2001 13:51:24 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: jamal <hadi@cyberus.ca>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Arjan van de Ven <arjanv@redhat.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, <netdev@oss.sgi.com>
Subject: Re: [patch] auto-limiting IRQ load take #2, irq-rewrite-2.4.11-F4
In-Reply-To: <Pine.GSO.4.30.0110031114490.4833-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.33L.0110031350530.26495-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2001, jamal wrote:

> Your approach is still wrong. Please do not accept this patch.

I rather like the fact that Ingo's approach will keep the
system alive regardless of what driver is used.

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

