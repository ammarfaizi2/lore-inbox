Return-Path: <linux-kernel-owner+w=401wt.eu-S1751152AbXAFChe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbXAFChe (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbXAFCgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:36:47 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:55134 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbXAFCgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:36:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=VkExsOPnIWxBYKKxcIOtIoDFjijIK3Q9LGWsA4CsTvWbD+zQSKXc/GHMO0ietjZaDw+k/2o9NCWunMMACGY4DoKwhMcFbXk9Z3saY2Vbud+lru5F2EXQBXNYX7HH0hXW1Wt+LU1axhD0enBaIZXI+1mexTCUK1n75lyDygXiakY=
Date: Sat, 6 Jan 2007 04:36:04 +0200
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] TTY_IO: Remove unnecessary kmalloc casts
Message-ID: <20070106023604.GC24091@Ahmed>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	linux-kernel@vger.kernel.org
References: <20070105063600.GA13571@Ahmed> <200701050910.11828.eike-kernel@sf-tec.de> <20070105100610.GA382@Ahmed> <Pine.LNX.4.64.0701050513360.23145@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701050513360.23145@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jan 05, 2007 at 09:10:01AM +0100, rday wrote:
> > Ahmed S. Darwish wrote:
> > Remove unnecessary kmalloc casts in drivers/char/tty_io.c
> > Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>
>
> rday
> 
> p.s.  just FYI, i have a patch that does most of this, but i was going
> to hold off submitting it until 2.6.20 had arrived.  but if you want
> to take a shot at it, it's all yours.

OK, then I should stop sending new patches related to that matter to avoid
patch conflicts. right ?

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
