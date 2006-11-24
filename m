Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933257AbWKXImX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933257AbWKXImX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 03:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934467AbWKXImX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 03:42:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:11224 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S933257AbWKXImW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 03:42:22 -0500
Date: Fri, 24 Nov 2006 00:13:54 -0800
From: Greg KH <greg@kroah.com>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: ltt-dev@shafik.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] DebugFS : inotify create/mkdir support
Message-ID: <20061124081354.GA1449@kroah.com>
References: <20061120181838.GB7328@Krystal> <20061122052730.GD20836@kroah.com> <20061123075148.GB1703@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123075148.GB1703@Krystal>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 02:51:48AM -0500, Mathieu Desnoyers wrote:
> Add inotify create and mkdir events to DebugFS.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

What kernel version are these patches against?  They don't seem to be
against the 2.6.19-rc6 kernel...

thanks,

greg k-h
