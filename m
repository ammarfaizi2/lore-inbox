Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbTBOTkn>; Sat, 15 Feb 2003 14:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbTBOTkm>; Sat, 15 Feb 2003 14:40:42 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:17078 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264745AbTBOTkm>; Sat, 15 Feb 2003 14:40:42 -0500
Date: Sat, 15 Feb 2003 13:50:35 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Mark Watts <m.watts@mrw.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.61 and ELSA Passive Isdn cards...
In-Reply-To: <200302151546.51952.m.watts@mrw.demon.co.uk>
Message-ID: <Pine.LNX.4.44.0302151349570.30618-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Mark Watts wrote:

> make && make modules_install appear to work fine, but the last thing I see 
> before being dumped back to the prompt is this:
> 
> WARNING: /lib/modules/2.5.61/kernel/drivers/isdn/hisax/hisax.ko needs unknown 
> symbol kstat__per_cpu

It's a known problem and on my list to fix. Unfortunately, fixing it 
properly isn't entirely trivial.

--kai

