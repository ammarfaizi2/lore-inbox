Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268652AbUHZLsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268652AbUHZLsU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268791AbUHZLnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:43:51 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:29323 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S268800AbUHZLgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:36:21 -0400
Date: Thu, 26 Aug 2004 13:35:41 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ELSA updated for kernel 2.6.8.1
Message-ID: <20040826113541.GA3022@frec.bull.fr>
References: <20040825115318.GA2721@frec.bull.fr> <20040826031906.5a8576ad.akpm@osdl.org>
Mime-Version: 1.0
In-Reply-To: <20040826031906.5a8576ad.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 26/08/2004 13:40:58,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 26/08/2004 13:41:01,
	Serialize complete at 26/08/2004 13:41:01
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 03:19:06AM -0700, Andrew Morton wrote:
> Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> >
> >   Here is the Enhanced Linux System Accounting patch for 
> >  kernel 2.6.8.1.
> 
> This looks suspiciously similar to SGI's Comprehensive System Accounting
> work.
> 
> Please see (and respond to) the comments regarding that code which I sent
> to this mailing list a few hours ago.

  You're right the goal is the same as SGI's Comprehensive System
Accounting. When I started this project there was _no_ activity from the
PAGG and CSA projects (it was during march if I remember). I saw that
possibility to do accounting not only for one process but for a group
of processes was missing in Linux. That's why, I started ELSA. 

I will respond to your comments regarding the two projects on lse-tech 
mailing list.

Regards,
Guillaume
