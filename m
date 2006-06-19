Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWFSLya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWFSLya (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 07:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWFSLya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 07:54:30 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:7385 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932397AbWFSLya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 07:54:30 -0400
Date: Mon, 19 Jun 2006 13:54:16 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Con Kolivas <kernel@kolivas.org>
cc: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-ck1
In-Reply-To: <200606190111.54914.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.61.0606191353210.31576@yvahk01.tjqt.qr>
References: <200606181736.38768.kernel@kolivas.org>
 <Pine.LNX.4.61.0606181703380.8787@yvahk01.tjqt.qr> <200606190111.54914.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Were you running them SCHED_IDLEPRIO or in compute mode? They would do that.
>
I have not changed anything, so I presume SCHED_NORMAL.
Unless they have been made SCHED_IDLEPRIO/compute by staircase's logic...


Jan Engelhardt
-- 
