Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbUCKBpc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 20:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbUCKBoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 20:44:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:20397 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262942AbUCKBnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 20:43:18 -0500
Date: Wed, 10 Mar 2004 17:29:45 -0800
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] class_simple cleanup in sg
Message-ID: <20040311012944.GE13045@kroah.com>
References: <20040303200625.N21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303200625.N21045@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 08:06:25PM -0800, Chris Wright wrote:
> The only spot that seems to care about class_simple_device_add possibly
> failing, but it gets the wrong error test.

Applied, thanks.

greg k-h
