Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265798AbSLNSxn>; Sat, 14 Dec 2002 13:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbSLNSxn>; Sat, 14 Dec 2002 13:53:43 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:3717 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S265798AbSLNSxn>; Sat, 14 Dec 2002 13:53:43 -0500
Date: Sat, 14 Dec 2002 13:01:20 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Brian Gerst <bgerst@didntduck.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove Rules.make from Makefiles (1/3)
In-Reply-To: <3DFB70D3.9010506@quark.didntduck.org>
Message-ID: <Pine.LNX.4.44.0212141258400.6813-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Dec 2002, Brian Gerst wrote:

> Makefiles no longer need to include Rules.make, which is currently an 
> empty file.  This patch removes it from the arch tree Makefiles.

I was hoping somebody would do the legwork here ;) I agree with these 
patches, I was just too lazy to do them myself yet. I'll pick them up if 
Linus didn't apply them already.

Thanks,
--Kai


