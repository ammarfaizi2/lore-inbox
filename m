Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTFIAao (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 20:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTFIAao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 20:30:44 -0400
Received: from granite.he.net ([216.218.226.66]:55816 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264095AbTFIAao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 20:30:44 -0400
Date: Sun, 8 Jun 2003 17:25:42 -0700
From: Greg KH <greg@kroah.com>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USB Scanner Problem
Message-ID: <20030609002542.GA2978@kroah.com>
References: <20030609021609.2722ebe1.us15@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030609021609.2722ebe1.us15@os.inf.tu-dresden.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 02:16:09AM +0200, Udo A. Steinberg wrote:
> 
> drivers/usb/image/scanner.c: USB scanner device (0x04b8/0x0110) now attached to @è^Ê@è^Ê€

Should already be fixed in the latest -bk tree.  If that doesn't fix it
for you, please let me know.

thanks,

greg k-h
