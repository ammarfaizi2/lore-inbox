Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVDEUvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVDEUvD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVDEUup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:50:45 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:5729 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262012AbVDEUtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:49:49 -0400
Subject: Re: [03/08] fix ia64 syscall auditing
From: Greg KH <gregkh@suse.de>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, amy.griffis@hp.com,
       tony.luck@intel.com, linux-ia64@vger.kernel.org, dwmw2@infradead.org
In-Reply-To: <16978.62622.80542.462568@napali.hpl.hp.com>
References: <20050405164539.GA17299@kroah.com>
	 <20050405164647.GD17299@kroah.com>
	 <16978.62622.80542.462568@napali.hpl.hp.com>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 13:49:18 -0700
Message-Id: <1112734158.468.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 13:27 -0700, David Mosberger wrote:
> >>>>> On Tue, 5 Apr 2005 09:46:48 -0700, Greg KH <gregkh@suse.de> said:
> 
>   Greg> -stable review patch.  If anyone has any objections, please
>   Greg> let us know.
> 
> Nitpick: the patch introduces trailing whitespace.

Sorry about that, I've removed it from the patch now.

> Why doesn't everybody use emacs and enable show-trailing-whitespace? ;-)

Because some of us use vim and ":set list" to see it, when we remember
to... :)

thanks,

greg k-h

