Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWBSWmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWBSWmE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 17:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWBSWmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 17:42:04 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:47575
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751113AbWBSWmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 17:42:03 -0500
Date: Sun, 19 Feb 2006 14:41:42 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: don't bother users with unimportant messages.
Message-ID: <20060219224142.GA3766@kroah.com>
References: <20060219010910.GA18841@redhat.com> <20060219081523.GA9668@flint.arm.linux.org.uk> <20060219082916.GA19903@redhat.com> <20060219175745.GB2674@kroah.com> <20060219183725.GC32492@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219183725.GC32492@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 01:37:25PM -0500, Dave Jones wrote:
> On Sun, Feb 19, 2006 at 09:57:45AM -0800, Greg Kroah-Hartman wrote:
> 
>  > >  > If you're getting complaints about this, wouldn't it be better to
>  > >  > forward them here so that they can be fixed up?
>  > > 
>  > > w83627hf, and probably other drivers from drivers/hwmon/
>  > 
>  > With 2.6.16-rc4?  I thought I just sent a patch in for -rc3 to fix this.
> 
> Yep, user was running an older kernel.
> Much ado about nothing..

Great, thanks for checking up on this.

greg k-h
