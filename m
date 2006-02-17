Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161143AbWBQAof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbWBQAof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 19:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbWBQAof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 19:44:35 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:32916
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1161143AbWBQAod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 19:44:33 -0500
Date: Thu, 16 Feb 2006 16:44:26 -0800
From: Greg KH <greg@kroah.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc3-git7 build failure if sysfs disabled
Message-ID: <20060217004426.GA19357@kroah.com>
References: <9a8748490602161542k1b282097ub754e6f0287780d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490602161542k1b282097ub754e6f0287780d2@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 12:42:01AM +0100, Jesper Juhl wrote:
> 2.6.16-rc3-git7 fails to build when sysfs is disabled with the
> attached .config .
> 
> Without sysfs enabled :

Yeah, someone else pointed this out a while ago too.  Care to make up a
patch to fix it?

thanks,

greg k-h
