Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289321AbSAVOi4>; Tue, 22 Jan 2002 09:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289319AbSAVOiq>; Tue, 22 Jan 2002 09:38:46 -0500
Received: from mustard.heime.net ([194.234.65.222]:47488 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S289323AbSAVOii>; Tue, 22 Jan 2002 09:38:38 -0500
Date: Tue, 22 Jan 2002 15:38:36 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: compiling a custom module into kernel
Message-ID: <Pine.LNX.4.30.0201221536420.1813-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I have this driver (intel e1000) that I need into kernel. I cannot use
initrd here, as the computer is supposed to boot up on the network,
something that doesn't work very well without having one.

Is there a nice way of putting this driver into kernel? Intel only ships
it as a module.

Thanks for any help.

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

