Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269140AbUJKQo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269140AbUJKQo5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 12:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269250AbUJKQor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 12:44:47 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:18648 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S269242AbUJKQaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 12:30:01 -0400
Subject: Re: [patch] 2.6.9-rc4: SCSI qla2xxx gcc 3.4 compile errors
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041011162457.GA3485@stusta.de>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org> 
	<20041011162457.GA3485@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 11 Oct 2004 11:28:42 -0500
Message-Id: <1097512128.1714.128.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 11:24, Adrian Bunk wrote:
> Please apply my patch below which is already for some time in James' 
> SCSI tree.

It's waiting in my tree until 2.6.9 goes final because gcc-3.4 fixes are
hardly showstoppers.  If you want to compile the kernel with gcc-3.4 use
-mm

James


