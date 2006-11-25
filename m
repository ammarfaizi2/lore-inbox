Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966530AbWKYT7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966530AbWKYT7t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 14:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967155AbWKYT7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 14:59:49 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:52667 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S966530AbWKYT7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 14:59:49 -0500
Date: Sat, 25 Nov 2006 14:57:29 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Josef Jeff Sipek <jsipek@cs.sunysb.edu>,
       Michael Halcrow <mhalcrow@us.ibm.com>
Subject: Re: [-mm patch] fs/stack.c should #include <linux/fs_stack.h>
Message-ID: <20061125195729.GA13470@filer.fsl.cs.sunysb.edu>
References: <20061123021703.8550e37e.akpm@osdl.org> <20061125191707.GK3702@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061125191707.GK3702@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 08:17:07PM +0100, Adrian Bunk wrote:
> Every file should #include the headers containing the prototypes for 
> its global functions.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Ack.

Josef "Jeff" Sipek.

-- 
We have joy, we have fun, we have Linux on a Sun...
