Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271647AbRIBRWB>; Sun, 2 Sep 2001 13:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271648AbRIBRVv>; Sun, 2 Sep 2001 13:21:51 -0400
Received: from mustard.heime.net ([194.234.65.222]:40161 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S271647AbRIBRVm>; Sun, 2 Sep 2001 13:21:42 -0400
Date: Sun, 2 Sep 2001 19:22:00 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: solo1 driver in 2.4.9
Message-ID: <Pine.LNX.4.30.0109021920010.9958-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

the solo1 driver in 2.4.9 seems to need the gameport symbols to compile.
Problem is - you need the -ac patches to get these symbols...

anyone know why?

please cc: to me as I'm not on the list

roy

