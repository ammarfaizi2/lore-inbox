Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWICVBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWICVBf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 17:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWICVBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 17:01:35 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:27866 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932147AbWICVBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 17:01:34 -0400
Date: Sun, 3 Sep 2006 23:01:15 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: in-kernel rpc.statd
In-Reply-To: <20060903180052.GA3743@pc51072.physik.uni-regensburg.de>
Message-ID: <Pine.LNX.4.61.0609032255010.6844@yvahk01.tjqt.qr>
References: <20060903180052.GA3743@pc51072.physik.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I'd like to ask if someone is maintaining a patchset, that implements
>the in-kernel rpc.statd (as found in SuSE kernels). I tried to fiddle
>some patches of Suse-10.1 into 2.6.17, but failed, unfortunately.

Hm. I do not have a rpc.statd userspace program nor kernel daemon (running 
on 2.6.17-vanilla). Yet everything is working. Is there a specific need for 
statd?


Jan Engelhardt
-- 

-- 
VGER BF report: H 7.21645e-16
