Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTLLT73 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 14:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTLLT72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 14:59:28 -0500
Received: from mail.kroah.org ([65.200.24.183]:4063 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261893AbTLLT72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 14:59:28 -0500
Date: Fri, 12 Dec 2003 11:45:05 -0800
From: Greg KH <greg@kroah.com>
To: Johannes Stezenbach <js@convergence.de>, sensors@stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11: i2c-dev.h for userspace
Message-ID: <20031212194505.GA11519@kroah.com>
References: <20031212145652.GA30747@convergence.de> <20031212175656.GA2933@kroah.com> <20031212185357.GB32169@convergence.de> <20031212190105.GB3038@kroah.com> <20031212192132.GC32169@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212192132.GC32169@convergence.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 08:21:32PM +0100, Johannes Stezenbach wrote:
> 
> IMHO the problem is that Linux 2.6.0 is about to be released with some
> broken driver API include files, and without a clear policy how driver
> authors, glibc and distribution maintainers and should handle
> the situation in a consistent way.

I'm not going to apply this patch, sorry.

greg k-h
