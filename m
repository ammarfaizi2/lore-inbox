Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbUJWRHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUJWRHW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 13:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbUJWRHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 13:07:22 -0400
Received: from p508B657D.dip.t-dialin.net ([80.139.101.125]:44336 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261244AbUJWRHU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 13:07:20 -0400
Date: Sat, 23 Oct 2004 19:05:05 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: fixed compile error
Message-ID: <20041023170505.GA17110@linux-mips.org>
References: <20041024010659.2c4a3f1e.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041024010659.2c4a3f1e.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 01:06:59AM +0900, Yoichi Yuasa wrote:

> This patch had fixed "causes a section type conflict".
> 
> ex.
> arch/mips/pci/fixup-mpc30x.c:32: error: irq_tab_mpc30x causes a section type conflict

This is bogus.

  Ralf
