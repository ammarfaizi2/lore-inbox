Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVGVQxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVGVQxT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 12:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVGVQxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 12:53:19 -0400
Received: from colin.muc.de ([193.149.48.1]:39439 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261333AbVGVQxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 12:53:18 -0400
Date: 22 Jul 2005 18:53:16 +0200
Date: Fri, 22 Jul 2005 18:53:16 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, discuss@x86_64.org
Subject: Re: Extending defconfig for x86_64
Message-ID: <20050722165316.GA19123@muc.de>
References: <20050721124739.A11717@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050721124739.A11717@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2005 at 12:47:39PM -0700, Ashok Raj wrote:
> Hi Andi
> 
> This patch is a trivial one. Provide a differnet defconfig for x86_64. 
> 
> Each time people get bitten by which scsi controller/eth to use. It might
> be possible to setup configs for other systems as well, if there are well
> known system names to make it simple for devl.

The defconfig should be pretty complete. I don't want to add
more to the standard kernel right now sorry because if we start
with that it would never end. But you can always
store them outside the kernel tree.


-Andi
