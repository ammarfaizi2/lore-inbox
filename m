Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263867AbTKAPvh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 10:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263872AbTKAPvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 10:51:37 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:40209 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263867AbTKAPvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 10:51:36 -0500
Date: Sat, 1 Nov 2003 16:51:31 +0100
From: Willy Tarreau <willy@w.ods.org>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.23-pre9: no problem so far
Message-ID: <20031101155131.GA530@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

just a simple report to tell you that I'm currently running 2.4.23-pre9 on
my alpha, and on a VIA eden and everything seems OK. BTW, on the alpha, I had
to disable IDE DMA on early 23pre's to boot (ali15x3), but it's now OK in pre9.

Cheers,
Willy
