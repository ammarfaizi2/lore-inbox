Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263325AbVBCMhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbVBCMhv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 07:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263601AbVBCMhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 07:37:51 -0500
Received: from p3EE07C05.dip.t-dialin.net ([62.224.124.5]:46962 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S263325AbVBCMhp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 07:37:45 -0500
Date: Thu, 3 Feb 2005 13:37:15 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.6.11-rc2-mm2] mips: iomap
Message-ID: <20050203123715.GB8509@linux-mips.org>
References: <20050131074618.09e65a6b.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050131074618.09e65a6b.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 07:46:18AM +0900, Yoichi Yuasa wrote:

> This patch adds iomap functions to MIPS system.

And it still only works for a single PCI bus.

  Ralf
