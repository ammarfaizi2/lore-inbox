Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266157AbRGDAhH>; Tue, 3 Jul 2001 20:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266090AbRGDAg5>; Tue, 3 Jul 2001 20:36:57 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:34991 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266084AbRGDAgr>; Tue, 3 Jul 2001 20:36:47 -0400
Date: Tue, 3 Jul 2001 20:36:47 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200107040036.f640alb18705@devserv.devel.redhat.com>
To: guthrie@martnet.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] small patch to ide-tape.c
In-Reply-To: <mailman.994203003.28209.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.994203003.28209.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch adds a missing semicolon that is noticed only if you define
> IDETAPE_DEBUG_LOG_VERBOSE:
> 
> John Guthrie
> guthrie@martnet.com

It makes me curious, why do you need to define
IDETAPE_DEBUG_LOG_VERBOSE?

I fixed some stuff with files not restoring properly
with last block corrupt. Talking with Andre and Gadi now.
What is your problem?

-- Pete
