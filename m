Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbTDWTUo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTDWTUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:20:44 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:47766 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264449AbTDWTUn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:20:43 -0400
Date: Wed, 23 Apr 2003 12:34:47 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB speedtouch: compile fix
Message-ID: <20030423193447.GC12674@kroah.com>
References: <200304231654.55881.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304231654.55881.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 04:54:55PM +0200, Duncan Sands wrote:
> The rx_inuse field no longer exists.

Applied, thanks,

greg k-h
