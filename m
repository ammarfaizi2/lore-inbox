Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268000AbUHEWmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268000AbUHEWmf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 18:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267906AbUHEWmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 18:42:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:32746 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268006AbUHEWmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 18:42:08 -0400
Date: Thu, 5 Aug 2004 15:41:46 -0700
From: Greg KH <greg@kroah.com>
To: John Rose <johnrose@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Linas Vepstas <linas@us.ibm.com>
Subject: Re: [PATCH] rpaphp build break - remove eeh register
Message-ID: <20040805224145.GC18523@kroah.com>
References: <1091548044.13500.4.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091548044.13500.4.camel@sinatra.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 10:47:25AM -0500, John Rose wrote:
> Hi Greg-
> 
> The following patch removes eeh function calls that currently break the
> RPA PCI Hotplug module.  The functions in question were rejected from
> mainline, and an alternate solution is being worked.

Applied, thanks.

greg k-h
