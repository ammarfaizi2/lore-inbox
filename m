Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVCTV4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVCTV4S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 16:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVCTV4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 16:56:18 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:55511 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261291AbVCTV4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 16:56:14 -0500
Date: Sun, 20 Mar 2005 22:55:15 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: bert hubert <ahu@ds9a.nl>
cc: Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: fuse is cool and robust
In-Reply-To: <20050320161529.GA26365@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.61.0503202254240.19507@yvahk01.tjqt.qr>
References: <E1DCLLi-0001Lx-00@dorka.pomaz.szeredi.hu> <20050320161529.GA26365@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I do understand that a filesystem is a particularly poor API for many
>things, and I'm not in favour of 'sqlfs' or 'ftpfs', but fuse IS a great
>enabler. 'encfs' would be hard to do from kernel space (or at least, a lot
>harder). http://arg0.net/users/vgough/encfs.html

encfs being hard from kernel space? I've seen a whole cryptoloop in the 
kernel. Can't be "hard". At least unpracticable.


Jan Engelhardt
-- 
