Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWEQW1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWEQW1e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWEQW1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:27:34 -0400
Received: from ns2.suse.de ([195.135.220.15]:57059 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751287AbWEQW1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:27:33 -0400
Date: Wed, 17 May 2006 15:25:22 -0700
From: Greg KH <gregkh@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       len.brown@intel.com
Subject: Re: [PATCH 17/22] [PATCH] i386/x86_64: Force pci=noacpi on HP XW9300
Message-ID: <20060517222522.GA23124@suse.de>
References: <20060517221312.227391000@sous-sol.org> <20060517221412.058186000@sous-sol.org> <200605180016.05127.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605180016.05127.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2006 at 12:16:04AM +0200, Andi Kleen wrote:
> On Wednesday 17 May 2006 09:00, Chris Wright wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> > ------------------
> 
> Who submitted that? I didn't

I did.

> There seems to be some controversy about this patch so better not put 
> it into stable for now.

Ok, that's fine, I'll go drop it, I thought it fixed some machines so I
added it.

thanks,

greg k-h
