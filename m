Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266632AbUBEUdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 15:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266629AbUBEUae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 15:30:34 -0500
Received: from mail.kroah.org ([65.200.24.183]:11172 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266564AbUBEU2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 15:28:01 -0500
Date: Thu, 5 Feb 2004 12:27:47 -0800
From: Greg KH <greg@kroah.com>
To: "Tillier, Fabian" <ftillier@infiniconsys.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, sean.hefty@intel.com,
       linux-kernel@vger.kernel.org, hozer@hozed.org, woody@co.intel.com,
       bill.magro@intel.com, woody@jf.intel.com,
       infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Message-ID: <20040205202747.GD14646@kroah.com>
References: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96BF@mercury.infiniconsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96BF@mercury.infiniconsys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 02:26:19PM -0500, Tillier, Fabian wrote:
> Do note that for non x86 architectures, the component library atomic
> abstraction is all #define to the Linux provided functions.  Only x86
> needed help because of i386 backwards compatibility which is not a goal
> of the InfiniBand project.

But that is a goal of the "Linux kernel" project :)

greg k-h
