Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbTFZDSz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 23:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265375AbTFZDSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 23:18:55 -0400
Received: from [66.212.224.118] ([66.212.224.118]:49937 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265285AbTFZDSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 23:18:54 -0400
Date: Wed, 25 Jun 2003 23:21:27 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Subject: Re: SOLVED - Testing IDE-TCQ and Taskfile - doesn't work nicely:)
In-Reply-To: <Pine.SOL.4.30.0306252117240.25993-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.53.0306252320410.31258@montezuma.mastecende.com>
References: <Pine.SOL.4.30.0306252117240.25993-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jun 2003, Bartlomiej Zolnierkiewicz wrote:

> Ehh... 3 weird bugreports (all are oopses):
> - on x86_64 with 32 bit userspace when reading /proc/ide/hdx/identify
> - in task_mulout_intr() on access to freed rq->bio
> - "bad: scheduling while atomic"

Perhaps if you can point me towards that one, i can try and give a hand

	Zwane
-- 
function.linuxpower.ca
