Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbTEEQif (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbTEEQgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:36:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:18682 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263728AbTEEQgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:36:39 -0400
Date: Mon, 5 May 2003 09:51:00 -0700
From: Greg KH <greg@kroah.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69-mm1 OOPS: modprobe usbcore
Message-ID: <20030505165059.GA1199@kroah.com>
References: <1052151088.1052.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052151088.1052.0.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 06:11:28PM +0200, Felipe Alfaro Solana wrote:
> 
> This error is reproducble 100% of the time when trying to boot Red Hat
> Linux 9 with a 2.5.69-mm1 kernel. Config attached.

Same thing happen on 2.5.69 (no mm)?

thanks,

greg k-h
