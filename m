Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVIUD4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVIUD4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 23:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbVIUD4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 23:56:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53930 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750996AbVIUD4a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 23:56:30 -0400
Date: Wed, 21 Sep 2005 04:56:15 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Sripathi Kodi <sripathik@in.ibm.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: [PATCH 2.6.13.1] Patch for invisible threads]
Message-ID: <20050921035615.GZ7992@ftp.linux.org.uk>
References: <432F4914.3080905@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432F4914.3080905@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 06:26:12PM -0500, Sripathi Kodi wrote:
> Al,
> 
> >>Al,
> >>Done. Please find the patch below. I retained proc_task_root_link, because
> >>it has significant amount of code in it.
> 
> 
> What do you feel about this patch now? Is it good enough to go into the 
> kernel?

ACK
