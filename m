Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279951AbRKFSji>; Tue, 6 Nov 2001 13:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279943AbRKFSj2>; Tue, 6 Nov 2001 13:39:28 -0500
Received: from mustard.heime.net ([194.234.65.222]:12713 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S279944AbRKFSiu>; Tue, 6 Nov 2001 13:38:50 -0500
Date: Tue, 6 Nov 2001 19:38:45 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: __FD_SETSIZE question
In-Reply-To: <E161BDK-0001N7-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0111061938030.25065-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It did long ago. Nowdays its limited by proc tunable variables - you do
> however want to use poll() not select()

ok... thanks. That someone mentioned in a discussion about Tux - may I
guess he was mistaken?

roy
--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

