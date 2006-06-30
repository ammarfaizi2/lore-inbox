Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWF3NpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWF3NpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 09:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWF3NpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 09:45:09 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:5838 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751182AbWF3NpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 09:45:07 -0400
Date: Fri, 30 Jun 2006 15:44:43 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Latchesar Ionkov <lionkov@gmail.com>
cc: Russ Cox <rsc@swtch.com>, Eric Sesterhenn <snakebyte@gmx.de>,
       linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [Patch] Dead code in fs/9p/vfs_inode.c
In-Reply-To: <f158dc670606290816p4a7add09mf6742d632ec12d28@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0606301544001.2313@yvahk01.tjqt.qr>
References: <1151535167.28311.1.camel@alice> 
 <ee9e417a0606281555k3d954236y82b11336098762be@mail.gmail.com> 
 <Pine.LNX.4.61.0606291300010.30453@yvahk01.tjqt.qr>
 <f158dc670606290816p4a7add09mf6742d632ec12d28@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The comment is longer than the 10 bytes we save :)

But comments are not compiled into the final binary,
which is what I wanted to point out. So you always
save your 10 bytes in the object file.


Jan Engelhardt
-- 
