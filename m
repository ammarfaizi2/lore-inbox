Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268055AbUI1WBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268055AbUI1WBJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 18:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268059AbUI1WBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 18:01:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:26283 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268055AbUI1WBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 18:01:04 -0400
Date: Tue, 28 Sep 2004 15:00:47 -0700
From: Greg KH <greg@kroah.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: akpm@osdl.org, Ashok Raj <ashok.raj@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add hook for PCI resource deallocation
Message-ID: <20040928220047.GB13816@kroah.com>
References: <41498CF6.9000808@jp.fujitsu.com> <20040924130251.A26271@unix-os.sc.intel.com> <20040924212208.GD7619@kroah.com> <4157CA04.5050604@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4157CA04.5050604@jp.fujitsu.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 05:06:28PM +0900, Kenji Kaneshige wrote:
> Hi Greg and Andrew,
> 
> I'm attaching updated patches for adding pcibiod_disable_device()
> hook based on the feedback from Ashok (Thank you, Ashok!).
> 
> I made two patches, one of them is against 2.6.9-rc2-mm1 and the
> another is against 2.6.9-rc2-mm4 to which the previous version of
> the patch has already been applyed. Please use the one convenient
> for you.

Based on all of the comments, I'll wait for you to incorporate them, so
I'm not going to apply this one.

thanks,

greg k-h
