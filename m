Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbUDEVlk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbUDEVVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:21:33 -0400
Received: from mail.kroah.org ([65.200.24.183]:23459 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263269AbUDEVUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:20:47 -0400
Date: Mon, 5 Apr 2004 12:44:44 -0700
From: Greg KH <greg@kroah.com>
To: Robert White <rwhite@casabyte.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Greg Lee <glee@casabyte.com>
Subject: Re: [linux-usb-devel] Kernel OOPS in usb_serial_disconnect (usbserial) 2.4.22
Message-ID: <20040405194444.GA15186@kroah.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAEnHRLBHGeUe6QdkwlqUiMAEAAAAA@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAEnHRLBHGeUe6QdkwlqUiMAEAAAAA@casabyte.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2004 at 07:36:03PM -0800, Robert White wrote:
> The usbserial.o driver module reliably/repeatedly produces an oops.

This should be fixed in the latest kernel version.

If not, please let us know.

thanks,

greg k-h
