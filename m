Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbUCKBoD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 20:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbUCKBoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 20:44:02 -0500
Received: from mail.kroah.org ([65.200.24.183]:15533 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262936AbUCKBnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 20:43:08 -0500
Date: Wed, 10 Mar 2004 17:29:23 -0800
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] class_simple clean up in lp
Message-ID: <20040311012923.GB13045@kroah.com>
References: <20040303195832.T22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303195832.T22989@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 07:58:32PM -0800, Chris Wright wrote:
> Error condition isn't caught on class_simple_create, and
> parport_register_driver failure doesn't do proper cleanup.

Applied, thanks.

greg k-h
