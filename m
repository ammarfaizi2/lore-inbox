Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTIJANX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 20:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265073AbTIJANX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 20:13:23 -0400
Received: from mail.kroah.org ([65.200.24.183]:43907 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265069AbTIJANW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 20:13:22 -0400
Date: Tue, 9 Sep 2003 17:13:47 -0700
From: Greg KH <greg@kroah.com>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] add kobject to struct module
Message-ID: <20030910001346.GA8846@kroah.com>
References: <20030909222421.GA7703@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030909222421.GA7703@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 03:24:21PM -0700, Greg KH wrote:
> So here's a patch that does this that is against 2.6.0-test4 (it
> applies with some fuzz, sorry.)

Ugh, that should read "2.6.0-test5"...

greg k-h
