Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262872AbVHEGRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbVHEGRK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 02:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbVHEGOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 02:14:42 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:44514 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262878AbVHEGO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 02:14:28 -0400
Date: Fri, 5 Aug 2005 08:13:12 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jiri Slaby <jirislaby@gmail.com>
cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Old api files, rewrite or delete?
In-Reply-To: <42F2944C.3000603@gmail.com>
Message-ID: <Pine.LNX.4.61.0508050811380.19610@yvahk01.tjqt.qr>
References: <42F20345.3020603@gmail.com> <20050804220357.GG4029@stusta.de>
 <42F2944C.3000603@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Nothing, I don't only want to rewrite driver, which others do not use.

Why rewrite? (unless it's an important api change) If it's some optimization 
patch that requires an almost-rewrite, well, do it and see if it gets 
accepted.



Jan Engelhardt
-- 
