Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVFQPW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVFQPW3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 11:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVFQPW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 11:22:29 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:29077 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261989AbVFQPW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 11:22:26 -0400
Date: Fri, 17 Jun 2005 17:22:25 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: getxpid, getxuid, getxgid
Message-ID: <20050617152225.GA28199@MAIL.13thfloor.at>
Mail-Followup-To: Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20050617053718.GA16080@MAIL.13thfloor.at> <20050617055634.GA24692@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050617055634.GA24692@twiddle.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 10:56:34PM -0700, Richard Henderson wrote:
> On Fri, Jun 17, 2005 at 07:37:18AM +0200, Herbert Poetzl wrote:
> > I would like to know why alpha seems to be the only
> > arch which has assembler code for some syscalls
> > (like the sys_getx* calls)
> 
> Compatibility with OSF/1.

hmm, and OSF/1 requires them to be written in assembler?

best,
Herbert

> 
> 
> r~
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
