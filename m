Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280815AbRKTBeH>; Mon, 19 Nov 2001 20:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280818AbRKTBdr>; Mon, 19 Nov 2001 20:33:47 -0500
Received: from chaos.ao.net ([205.244.242.21]:4796 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id <S280815AbRKTBdg>;
	Mon, 19 Nov 2001 20:33:36 -0500
Message-Id: <200111200133.fAK1XT2J000773@vulpine.ao.net>
To: linux-kernel@vger.kernel.org
Subject: radeonfb bug: text ends up scrolling in the middle of tux.
Date: Mon, 19 Nov 2001 20:33:29 -0500
From: Dan Merillat <harik@chaos.ao.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I've poked around but I can't find a penguin or tux bitmap to
figure out why scrolling is so broken.  I've got to login blind and type
reset to get the console back.  Needless to say, no kernel messages
are readable after the mode-switch (they all overwrite themselves on
a single line)

This is recent 2.4.X kernels (up to and including .15-pre6)  An annoying
bug, be good to catch it before final.

--Dan

