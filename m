Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266852AbUBEV1P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266881AbUBEV1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:27:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:20153 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266852AbUBEV1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:27:10 -0500
Date: Thu, 5 Feb 2004 13:27:03 -0800
From: Greg KH <greg@kroah.com>
To: "Tillier, Fabian" <ftillier@infiniconsys.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, sean.hefty@intel.com,
       linux-kernel@vger.kernel.org, hozer@hozed.org, woody@co.intel.com,
       bill.magro@intel.com, woody@jf.intel.com,
       infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Message-ID: <20040205212703.GA15718@kroah.com>
References: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96CF@mercury.infiniconsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96CF@mercury.infiniconsys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A: No.
Q: Should I include quotations after my reply?

On Thu, Feb 05, 2004 at 03:32:09PM -0500, Tillier, Fabian wrote:
> So which is more important to the "Linux kernel" project: i386 backwards
> compatibility, or consistent API and functionality across processor
> architectures? ;)

Anyway, why not describe what you are trying to accomplish that made you
determine that you _had_ to have these kinds of functions.

Basically, what is lacking in the current kernel locks that the
infiniband project has to have in order to work properly.  We can work
from there.

thanks,

greg k-h
