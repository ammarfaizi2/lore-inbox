Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVDFAFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVDFAFT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 20:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVDFAFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 20:05:19 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:58219 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261829AbVDFAFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 20:05:15 -0400
Subject: Re: [03/08] fix ia64 syscall auditing
From: Greg KH <gregkh@suse.de>
To: Ryan Anderson <ryan@michonline.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, stable@kernel.org,
       amy.griffis@hp.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
       dwmw2@infradead.org
In-Reply-To: <20050405234602.GC4800@mythryan2.michonline.com>
References: <20050405164539.GA17299@kroah.com>
	 <20050405164647.GD17299@kroah.com>
	 <16978.62622.80542.462568@napali.hpl.hp.com>
	 <1112734158.468.0.camel@localhost.localdomain>
	 <20050405234602.GC4800@mythryan2.michonline.com>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 17:05:04 -0700
Message-Id: <1112745904.412.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 19:46 -0400, Ryan Anderson wrote:
> highlight WhitespaceEOL ctermbg=red guibg=red
> match WhitespaceEOL /\s\+$/

Very nice, thanks a lot for that.

greg k-h

