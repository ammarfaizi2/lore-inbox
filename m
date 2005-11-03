Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030531AbVKCX1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030531AbVKCX1E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030527AbVKCX1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:27:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:57026 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030504AbVKCX1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:27:03 -0500
Date: Thu, 3 Nov 2005 15:05:51 -0800
From: Greg KH <greg@kroah.com>
To: Michael Thompson <michael.craig.thompson@gmail.com>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
Subject: Re: [PATCH 1/12: eCryptfs] Makefile and Kconfig
Message-ID: <20051103230551.GB30487@kroah.com>
References: <20051103033220.GD2772@sshock.rn.byu.edu> <20051103034207.GA3005@sshock.rn.byu.edu> <afcef88a0511030721g68ddf71bjf02397abcd8da30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afcef88a0511030721g68ddf71bjf02397abcd8da30@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 09:21:16AM -0600, Michael Thompson wrote:
> On 11/2/05, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> > These patches modify fs/Makefile and fs/Kconfig to provide build
> > support for eCryptfs.
> >
> > Signed off by: Phillip Hellewell <phillip@hellewell.homeip.net>
> > Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>
> > Signed off by: Michael Thompson <mmcthomps@us.ibm.com>
> 
> That should read:
> Signed off by: Michael Thompson <mcthomps@us.ibm.com>

No, that's not how it is documented on how to do this.  Please try
again.

thanks,

greg k-h
