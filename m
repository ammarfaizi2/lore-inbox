Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbSLIEl2>; Sun, 8 Dec 2002 23:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262804AbSLIEl2>; Sun, 8 Dec 2002 23:41:28 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:39134 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262796AbSLIEl2>; Sun, 8 Dec 2002 23:41:28 -0500
Date: Sun, 8 Dec 2002 22:49:07 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Christian Kurz <lk@getuid.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in 2.5.47
In-Reply-To: <20021208104540.GA843@salem.getuid.de>
Message-ID: <Pine.LNX.4.44.0212082246470.28286-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Dec 2002, Christian Kurz wrote:

> I found the kernel bug by compiling ISDN and the hisax driver directly 
> into the kernel. When I then booted the kernel (via grub) and passed the
> option hisax=18,2,Elsa0, the kernel will start booting and suddenly stop
> with the following message:

Sorry for the late reply. Anyway, I think that's a known problem (at least 
to me ;). I have a much updated version of hisax here (no more cli()'s),
but it's not quite ready for submission to Linus yet. So it'd be nice if 
you have just a little more patience, I'm working on it, but it'll take 
quite a bit to completely stabilize ISDN again.

--Kai


