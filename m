Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032070AbWLGLsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032070AbWLGLsD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 06:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032080AbWLGLsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 06:48:01 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:37051 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032070AbWLGLsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 06:48:00 -0500
Message-ID: <4577FF6A.6060703@pobox.com>
Date: Thu, 07 Dec 2006 06:47:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Michael Chan <mchan@broadcom.com>, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/bnx2.c: add an error check
References: <20061207113433.GC8963@stusta.de>
In-Reply-To: <20061207113433.GC8963@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch adds a missing error check spotted by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

ACK


