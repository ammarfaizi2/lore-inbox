Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVANTUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVANTUu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVANTTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:19:22 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:32180 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262071AbVANTRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 14:17:55 -0500
Date: Fri, 14 Jan 2005 11:17:52 -0800
From: Greg KH <greg@kroah.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH 2/4] relayfs for 2.6.10: common files
Message-ID: <20050114191752.GD15337@kroah.com>
References: <41E736BF.1020902@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E736BF.1020902@opersys.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 10:04:31PM -0500, Karim Yaghmour wrote:
> 
> The basic relayfs files.

Shouldn't the klog stuff be a separate patch?

thanks,

greg k-h
