Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269101AbUJKRKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269101AbUJKRKK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 13:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268957AbUJKRHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 13:07:37 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:39595 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S269065AbUJKRGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 13:06:22 -0400
Subject: Re: [patch] 2.6.9-rc4: SCSI qla2xxx gcc 3.4 compile errors
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041011163501.GB3485@stusta.de>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
	<20041011162457.GA3485@stusta.de> <1097512128.1714.128.camel@mulgrave> 
	<20041011163501.GB3485@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 11 Oct 2004 12:05:08 -0500
Message-Id: <1097514314.1714.155.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 11:35, Adrian Bunk wrote:
> It's the only compile error with gcc 3.4 I found in 2.6.9-rc4, and the 
> fix is pretty low-risk.

But also not essential.  If we apply lots of inessential but low risk
fixes, all we end up with is merge problems in the various BK trees and
no real benefit.  The fix is queued, it will be in early 2.6.9, just be
patient.

James


