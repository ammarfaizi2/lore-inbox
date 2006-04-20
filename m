Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWDTRzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWDTRzI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWDTRzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:55:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:25320 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751200AbWDTRzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:55:06 -0400
Date: Thu, 20 Apr 2006 10:50:43 -0700
From: Tony Jones <tonyj@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 10/11] security: AppArmor - Add flags to d_path
Message-ID: <20060420175043.GA32382@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419175026.29149.23661.sendpatchset@ermintrude.int.wirex.com> <20060419221248.GB26694@infradead.org> <20060420053604.GA15332@suse.de> <1145521570.3023.8.camel@laptopd505.fenrus.org> <20060420164329.GA30219@suse.de> <20060420170419.GA20791@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420170419.GA20791@infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 06:04:19PM +0100, Christoph Hellwig wrote:

> p.s.: I also see that your patch doesn't include on to export d_path so
> couldn't actually use it anyway. Not that a patch to export it would ever
> be ACKed for above reasons..

Don't understand. Are you saying there is no EXPORT_SYMBOL for d_path?

I didn't add one as I didn't remove the old one.  It's still there.

Thanks

Tony
