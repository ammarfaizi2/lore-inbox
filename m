Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267779AbUHXNEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267779AbUHXNEl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 09:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbUHXNEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 09:04:41 -0400
Received: from mail5.ewetel.de ([212.6.122.32]:51607 "EHLO mail5.ewetel.de")
	by vger.kernel.org with ESMTP id S267779AbUHXNEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 09:04:37 -0400
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
In-Reply-To: <2wAWW-12a-11@gated-at.bofh.it>
References: <2wAWW-12a-11@gated-at.bofh.it>
Date: Tue, 24 Aug 2004 15:04:22 +0200
Message-Id: <E1BzayM-00005W-Oc@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004 06:20:06 +0200, you wrote in linux.kernel:

> Dou you know of any other system where you can say:
>
> 	Print me a strack trace with symbols for all processes on this
> 	computer (even stripped ones) that call gettimeofday() within the
> 	next few seconds.

Well, this is by far off-topic here now, but how does this solve
the general problem of knowing that gettimeofday() might be a
problem in the given situation? But yeah, once you know that,
the functionality is useful, no doubt.

-- 
Ciao,
Pascal
