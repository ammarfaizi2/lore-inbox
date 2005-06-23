Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262911AbVFWXqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbVFWXqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 19:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbVFWXqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 19:46:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:26753 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262911AbVFWXqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 19:46:34 -0400
Date: Thu, 23 Jun 2005 16:43:56 -0700
From: Greg KH <greg@kroah.com>
To: Clyde Griffin <CGRIFFIN@novell.com>
Cc: linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>
Subject: Re: Novell Linux Kernel Debugger (NLKD)
Message-ID: <20050623234356.GA21406@kroah.com>
References: <s2bae938.075@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s2bae938.075@sinclair.provo.novell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 04:54:09PM -0600, Clyde Griffin wrote:
> 
> Patches against the mainline will be forthcoming after community feedback.

Please provide patches against a mainline kernel, otherwise it's pretty
much impossible to review.

And try to reduce the ammount of #ifdev CONFIG_CDE you have placed in
your patch, it's quite excessive and against the kernel coding style
rules.

thanks,

greg k-h
