Return-Path: <linux-kernel-owner+w=401wt.eu-S965278AbXATOjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965278AbXATOjo (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 09:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbXATOjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 09:39:43 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:59661 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965278AbXATOjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 09:39:42 -0500
Date: Sat, 20 Jan 2007 14:39:22 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] mips: remove the broken BINFMT_IRIX code
Message-ID: <20070120143922.GA30336@linux-mips.org>
References: <20070120140135.GT9093@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070120140135.GT9093@stusta.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2007 at 03:01:35PM +0100, Adrian Bunk wrote:

> The BINFMT_IRIX code:
> - has been marked as BROKEN for more than two years years and
> - is still marked as BROKEN.
> 
> Code that has been marked as BROKEN for such a long time seem to be 
> unlikely to be revived in the forseeable future.
> 
> But if anyone wants to ever revive this driver, the code is still
> present in the older kernel releases.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

NAK.

Steven Hill is working on it and the reason why it's marked broken is tiny
anyway.

  Ralf
