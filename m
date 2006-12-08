Return-Path: <linux-kernel-owner+w=401wt.eu-S1425556AbWLHPWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425556AbWLHPWr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425554AbWLHPWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:22:47 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:50288 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425556AbWLHPWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:22:46 -0500
Date: Fri, 8 Dec 2006 15:22:42 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][resend] fix PNX8550 serial breakage
Message-ID: <20061208152242.GA17645@linux-mips.org>
References: <20061207182439.b571ecda.vitalywool@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207182439.b571ecda.vitalywool@gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 06:24:39PM +0300, Vitaly Wool wrote:

> inlined is the patch (being resent) that fixes the serial header breakage for the PNX8550 MIPS platform.

Patch seems broken:

patching file include/linux/serial_ip3106.h
The next patch would create the file include/linux/serial_pnx8xxx.h,
which already exists!  Assume -R? [n] y
patching file include/linux/serial_pnx8xxx.h
patching file include/linux/serial_core.h

  Ralf
