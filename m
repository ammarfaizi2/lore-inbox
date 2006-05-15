Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbWEOTNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbWEOTNt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbWEOTNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:13:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5523 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751625AbWEOTNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:13:48 -0400
Date: Mon, 15 May 2006 12:16:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.6.17-rc4-mm1 klibc build misbehavior
Message-Id: <20060515121630.2a91235b.akpm@osdl.org>
In-Reply-To: <200605151907.k4FJ7Olk006598@turing-police.cc.vt.edu>
References: <200605151907.k4FJ7Olk006598@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> Why does touching scripts/mod/modpost.c end up rebuilding all of klibc?
> 
> Oddly enough, it *didn't* force a rebuild of all the *.ko files.
> 

cc added.
