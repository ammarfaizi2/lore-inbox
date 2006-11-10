Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946513AbWKJL57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946513AbWKJL57 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 06:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946514AbWKJL57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 06:57:59 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:11749 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1946513AbWKJL57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 06:57:59 -0500
Date: Fri, 10 Nov 2006 12:57:37 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Stuart MacDonald <stuartm@connecttech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: read/write interruptible semaphores?
In-Reply-To: <000001c70420$7dbbe940$294b82ce@stuartm>
Message-ID: <Pine.LNX.4.61.0611101257200.6068@yvahk01.tjqt.qr>
References: <000001c70420$7dbbe940$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>There's down_interruptible() for regular semaphores, but there doesn't
>seem to be down_(read|write)_interruptible() for rwsems.
>
>Any reason why, besides that no one's needed them yet?

Can't use struct rwsem?


	-`J'
-- 
