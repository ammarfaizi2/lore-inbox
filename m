Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVFPR6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVFPR6x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 13:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVFPR6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 13:58:53 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:16146 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S261781AbVFPR6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 13:58:52 -0400
Date: Thu, 16 Jun 2005 18:58:51 +0100
From: Simon Richard Grint <rgrint@mrtall.compsoc.man.ac.uk>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: arch/i386/boot/video.S hang
Message-ID: <20050616175851.GA22103@mrtall.compsoc.man.ac.uk>
References: <20050615220554.GA1911@srg.demon.co.uk> <20050616103340.A4951@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050616103340.A4951@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-UoM: Scanned by the University Mail System. See http://www.mcc.ac.uk/cos/email/scanning for details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 10:33:41AM -0700, Venkatesh Pallipadi wrote:
> What boot loader are you using. grub/lilo?

The same thing happens with either grub or lilo, but I'm using grub at 
present
 
> Does it work with CONFIG_VIDEO_SELECT disabled in your kernel CONFIG?

It works fine if CONFIG_VIDEO_SELECT is disabled.  Even with 
CONFIG_VIDEO_SELECT enabled, the problem only arises if I pass a vga= 
parameter to the kernel

Thanks for your help

sr
