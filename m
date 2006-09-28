Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965322AbWI1Mqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965322AbWI1Mqf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 08:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965410AbWI1Mqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 08:46:35 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:29404 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S965322AbWI1Mqe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 08:46:34 -0400
Date: Thu, 28 Sep 2006 13:47:25 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org
Subject: Re: [PATCH] QEMU - Add support for little endian mips
Message-ID: <20060928124725.GA30521@linux-mips.org>
References: <20060927210723.GA28334@bode.aurel32.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060927210723.GA28334@bode.aurel32.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 11:07:25PM +0200, Aurelien Jarno wrote:

> This very small patch adds support for little endian on the virtual QEMU
> mips platform. The status of this platform is the same as the big endian
> one, ie it is possible to boot a system with init=/bin/sh.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Applied.  Thanks,

  Ralf
