Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVBXSBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVBXSBC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 13:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbVBXSBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 13:01:01 -0500
Received: from mail.kroah.org ([69.55.234.183]:21969 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262436AbVBXSAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 13:00:50 -0500
Date: Thu, 24 Feb 2005 10:00:39 -0800
From: Greg KH <greg@kroah.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH] CKRM [7/8]  Resource controller for number of tasks per class
Message-ID: <20050224180039.GA10569@kroah.com>
References: <E1D4FOI-0006wW-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1D4FOI-0006wW-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 01:34:38AM -0800, Gerrit Huizenga wrote:
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <asm/errno.h>
> +#include <asm/div64.h>
> +#include <linux/list.h>
> +#include <linux/spinlock.h>
> +#include <linux/ckrm_rc.h>
> +#include <linux/ckrm_tc.h>
> +#include <linux/ckrm_tsk.h>

What was that response you gave me about the fact that you fixed up the
proper ordering of #include files...

I'll just stop reading now, sorry.

greg k-h
