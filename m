Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbTDJAFz (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 20:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263958AbTDJAFz (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 20:05:55 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:22014 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263946AbTDJAFy (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 20:05:54 -0400
Date: Wed, 9 Apr 2003 17:19:15 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Backport of USB speedtouch driver to 2.4
Message-ID: <20030410001915.GB3542@kroah.com>
References: <200304042115.00706.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304042115.00706.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 09:15:00PM +0200, Duncan Sands wrote:
> Since the 2.5 crc library hasn't been backported
> to the 2.4 tree yet, I included a crc routine in
> the speedcrc files.

Applied to my 2.4 tree, but I will hold off sending it to Marcelo until
2.4.21 comes out.

thanks,

greg k-h
