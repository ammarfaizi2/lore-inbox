Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264432AbUFNVg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbUFNVg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 17:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbUFNVg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 17:36:57 -0400
Received: from mail.kroah.org ([65.200.24.183]:36558 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264432AbUFNVg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 17:36:56 -0400
Date: Mon, 14 Jun 2004 14:21:30 -0700
From: Greg KH <greg@kroah.com>
To: Shaun Colley <shaunige@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i2c device driver bugs
Message-ID: <20040614212130.GA3292@kroah.com>
References: <20040613184116.76173.qmail@web25105.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040613184116.76173.qmail@web25105.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 07:41:16PM +0100, Shaun Colley wrote:
> Hehe, forgot to specify which kernel source I read
> this from.  Well, the first issue seems to be present
> in all of the 2.4 kernels, and 2.5 -- I haven't
> checked 2.6 yet.

Please let us know exactly what kernel version you see this in.  It
looks to me that it is fixed in the latest 2.4 and 2.6 versions.  If you
do not think so, please let us know.

thanks,

greg k-h
