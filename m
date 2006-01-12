Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbWALQAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbWALQAg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 11:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbWALQAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 11:00:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:52945 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030451AbWALQAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 11:00:33 -0500
Date: Wed, 11 Jan 2006 17:37:06 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
Subject: Re: git pull on Linux/ACPI release tree
Message-ID: <20060112013706.GA3339@kroah.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com> <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org> <20060108230611.GP3774@stusta.de> <Pine.LNX.4.64.0601081909250.3169@g5.osdl.org> <20060110201909.GB3911@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110201909.GB3911@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 09:19:09PM +0100, Adrian Bunk wrote:
> 
> I am using the workaround of carrying the patches in a mail folder, 
> applying them in a batch, and not pulling from your tree between 
> applying a batch of patches and you pulling from my tree.

Ick, I'd strongly recommend using quilt for this.  It works great for
just this kind of workflow.

thanks,

greg k-h
