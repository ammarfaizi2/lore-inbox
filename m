Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTFPViO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 17:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTFPViO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 17:38:14 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:12043 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264358AbTFPViM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 17:38:12 -0400
Subject: Re: [BUG] 2.4.21: NFS copy produces I/O errors
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Ole Marggraf <marggraf@astro.uni-bonn.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0306162047140.6775@aibn99.astro.uni-bonn.de>
References: <Pine.LNX.4.55.0306162047140.6775@aibn99.astro.uni-bonn.de>
Content-Type: text/plain
Message-Id: <1055800323.586.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 16 Jun 2003 23:52:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-16 at 20:51, Ole Marggraf wrote:
> Hello all.
> 
> As it seems (to me), there is some serious problem in the NFS code of
> 2.4.21 (and also of 2.4.20), causing I/O errors quite immediately.

By the way, are you using the "soft" option to mount the NFS volumes?

