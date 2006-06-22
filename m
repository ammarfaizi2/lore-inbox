Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbWFVVcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbWFVVcm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWFVVck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:32:40 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:3562 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932664AbWFVVcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:32:16 -0400
Date: Thu, 22 Jun 2006 23:28:55 +0200
From: Mattia Dongili <malattia@linux.it>
To: Greg KH <greg@kroah.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-pm@osdl.org, pavel@suse.cz
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
Message-ID: <20060622212855.GA4891@inferi.kami.home>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Jiri Slaby <jirislaby@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	linux-pm@osdl.org, pavel@suse.cz
References: <20060622202952.GA14135@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622202952.GA14135@kroah.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.17-mm1-3 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 01:29:52PM -0700, Greg KH wrote:
> Mattai and Jiri, can you try the patch below to see if it fixes the USB
> suspend problem you are seeing with 2.6.17-mm1?

it does, s2ram now works again

thanks
-- 
mattia
:wq!
