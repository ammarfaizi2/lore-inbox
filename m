Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290277AbSA3Ryi>; Wed, 30 Jan 2002 12:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290054AbSA3RxK>; Wed, 30 Jan 2002 12:53:10 -0500
Received: from mustard.heime.net ([194.234.65.222]:3813 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S290286AbSA3RwF>; Wed, 30 Jan 2002 12:52:05 -0500
Date: Wed, 30 Jan 2002 18:51:55 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>, Knut Olav Boehmer <knuto@linpro.no>,
        Frank Ronny Larsen <gobo@gimle.nu>
Subject: Re: still problems with heavy i/o load
In-Reply-To: <Pine.LNX.4.30.0201301825470.31732-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.30.0201301850470.31929-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> strangely, rmap11c seems to be quite stable, but only gives me ~32MB/s,
> whereas the initial is close to 50.

This is not the case. After some time it failes on the same point, leaving
60 blocked clients on the client computer.

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

