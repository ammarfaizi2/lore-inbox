Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262931AbVCEQmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbVCEQmE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 11:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVCEQhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 11:37:04 -0500
Received: from 64-85-47-3.ip.van.radiant.net ([64.85.47.3]:23825 "EHLO
	vlinkmail") by vger.kernel.org with ESMTP id S263105AbVCEQfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 11:35:34 -0500
Date: Sat, 5 Mar 2005 08:33:00 -0800
From: Greg KH <greg@kroah.com>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
Message-ID: <20050305163259.GA9865@kroah.com>
References: <11099685952869@kroah.com> <200503050057.44233.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503050057.44233.shawn.starr@rogers.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 12:57:42AM -0500, Shawn Starr wrote:
> How does this fit into Rusty's trivial patch bot?  This process will fold that 
> into a formal method now?

The last rule explicitly states that the linux-release tree will _not_
be accepting patches that are acceptable to the trivial-patch-monkey.

thanks,

greg k-h
