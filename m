Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbUKCVwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUKCVwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUKCVuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:50:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:39042 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261913AbUKCVqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:46:20 -0500
Date: Wed, 3 Nov 2004 13:41:25 -0800
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] small sysfs cleanups
Message-ID: <20041103214125.GA30482@kroah.com>
References: <20041030180939.GU4374@stusta.de> <20041031230619.GA14048@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031230619.GA14048@in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 05:06:20PM -0600, Maneesh Soni wrote:
> On Sat, Oct 30, 2004 at 08:09:39PM +0200, Adrian Bunk wrote:
> > The patch below does the following cleanups for the sysfs code:
> > - remove the unused global function sysfs_mknod
> 
> It is not used as of now, but I am not sure if there are potential
> users been thought earlier.
> 
> > - make some structs and functions static
> 
> Looks good to me.

Applied, thanks.

greg k-h
