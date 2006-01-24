Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWAXU7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWAXU7s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 15:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWAXU7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 15:59:48 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2761
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750701AbWAXU7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 15:59:48 -0500
Date: Tue, 24 Jan 2006 12:57:59 -0800 (PST)
Message-Id: <20060124.125759.126218181.davem@davemloft.net>
To: j.borsboom@erasmusmc.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no message type set in af_key.c, linux-2.6.15
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0601112108040.446@knorkaan.xs4all.nl>
References: <Pine.LNX.4.64.0601112108040.446@knorkaan.xs4all.nl>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Borsboom <j.borsboom@erasmusmc.nl>
Date: Wed, 11 Jan 2006 21:20:06 +0100 (CET)

> When returning a message to userspace in reply to a SADB_FLUSH or 
> SADB_X_SPDFLUSH message, the type was not set for the returned PFKEY 
> message. The patch below corrects this problem.
> 
> Signed-off-by: Jerome Borsboom <j.borsboom@erasmusmc.nl>

Applied, thanks Jerome.
