Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbTEETEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 15:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbTEETEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 15:04:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:24247 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261234AbTEETEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 15:04:52 -0400
Date: Mon, 5 May 2003 12:19:06 -0700
From: Greg KH <greg@kroah.com>
To: Andrei Ivanov <andrei.ivanov@ines.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb [mouse] not working in mm4
Message-ID: <20030505191906.GB2277@kroah.com>
References: <Pine.LNX.4.50L0.0305031550330.4098-200000@webdev.ines.ro> <20030503193135.GA17970@kroah.com> <Pine.LNX.4.50L0.0305041235580.4098-100000@webdev.ines.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L0.0305041235580.4098-100000@webdev.ines.ro>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 12:38:04PM +0300, Andrei Ivanov wrote:
> 
> 
> No, on bk11 it does the same thing.

Booting with "noapic" help any?

Or if this is a acpi based box, can you disable that?

thanks,

greg k-h
