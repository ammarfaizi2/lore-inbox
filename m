Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbULKTKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbULKTKv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 14:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbULKTKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 14:10:51 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59045 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261609AbULKTKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 14:10:50 -0500
Date: Sat, 11 Dec 2004 20:09:33 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Grzegorz Piotr Jaskiewicz <gj@kde.org.uk>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: query sysctls questions
In-Reply-To: <41BB1AA3.6080606@kde.org.uk>
Message-ID: <Pine.LNX.4.53.0412112009180.30929@yvahk01.tjqt.qr>
References: <41BB1AA3.6080606@kde.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What would be the best way to get list of avaliable sysctl calls for
>kernel 2.4 and 2.6. The best would be to get it from binaries, but
>headers are avaliable too. It needs to be automated way, script or program.

`sysctl -a` and/or its source code, probably?



Jan Engelhardt
-- 
ENOSPC
