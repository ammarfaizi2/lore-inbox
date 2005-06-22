Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVFVNc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVFVNc1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 09:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVFVNc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 09:32:27 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:43787 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261281AbVFVNav
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 09:30:51 -0400
Date: Wed, 22 Jun 2005 09:25:20 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: UML problems / kernel panic
Message-ID: <20050622132520.GA4440@ccure.user-mode-linux.org>
References: <20050622101707.GP2779@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050622101707.GP2779@schottelius.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 12:17:07PM +0200, Nico Schottelius wrote:
> Hello!
> 
> Sometimes when I "boot" 2.6.11.11/um, I get the following error:
> 
> --------------------------------------------------------------
> VFS: Mounted root (jfs filesystem) readonly.
> cinit-0.1 booting...
> Kernel panic - not syncing: write of switch_pipe failed, err = 9

That bug has been fixed since 2.6.11.

				Jeff
