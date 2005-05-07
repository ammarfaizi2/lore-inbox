Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVEGSIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVEGSIs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 14:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbVEGSIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 14:08:47 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:11527 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262735AbVEGSIq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 14:08:46 -0400
Date: Sat, 7 May 2005 14:03:56 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Alexander Nyberg <alexn@telia.com>
Cc: Antoine Martin <antoine@nagafix.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
Message-ID: <20050507180356.GA10793@ccure.user-mode-linux.org>
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net> <1115248927.12088.52.camel@cobra> <1115392141.12197.3.camel@cobra> <1115483506.12131.33.camel@cobra> <1115481468.925.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115481468.925.9.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 05:57:48PM +0200, Alexander Nyberg wrote:
> I never get uml to compile around here, 2.6.12-rc3 + that patchkit from
> the link you sent blows up with defconfig any my minimal config. Please
> attach your guest .config and if you can you might aswell put your guest
> vmlinux somewhere where i can download it too.

Start with -rc3, and all the patches from
	http://user-mode-linux.sf.net/patches.html
up to and including skas0.  You'll see a note to x86_64 users on that patch.

				Jeff
