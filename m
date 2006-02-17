Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWBQWHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWBQWHM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 17:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWBQWHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 17:07:12 -0500
Received: from [217.7.64.195] ([217.7.64.195]:31648 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S1751445AbWBQWHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 17:07:10 -0500
From: Ernst Herzberg <earny@net4u.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc3 macromedia flash regression...
Date: Fri, 17 Feb 2006 23:07:06 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200602170508.52712.list-lkml@net4u.de> <200602172038.10408.earny@net4u.de> <20060217131618.0a463a8b.akpm@osdl.org>
In-Reply-To: <20060217131618.0a463a8b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602172307.06388.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 February 2006 22:16, Andrew Morton wrote:
> Ernst Herzberg <earny@net4u.de> wrote:
> > The patch does _not_ fix the problem.
>
> Surprised.  Could I ask that you double-check that the patch was applied
> and that the right kernel was running?

**doublechecked**, and..... you are right!

This patch __fixes__ the problem.

Thanks

<earny/>
