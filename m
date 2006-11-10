Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946050AbWKJIfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946050AbWKJIfH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 03:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946055AbWKJIfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 03:35:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:58272 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1946050AbWKJIfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 03:35:05 -0500
Date: Fri, 10 Nov 2006 09:50:12 +0900
From: Greg KH <gregkh@suse.de>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] PCI: check szhi when sz is 0 for 64 bit pref mem
Message-ID: <20061110005012.GA967@suse.de>
References: <5986589C150B2F49A46483AC44C7BCA49071B7@ssvlexmb2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA49071B7@ssvlexmb2.amd.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 11:15:59AM -0800, Lu, Yinghai wrote:
> -----Original Message-----
> From: Andrew Morton [mailto:akpm@osdl.org] 
> 
> >I've basically given up in exhaustion on that patch.  Maybe when I have
> a
> >burst of extra energy I'll go back and take the time to understand it,
> >or maybe when Greg comes back he'll save me.
> 
> Please 
> http://lkml.org/lkml/2006/11/6/341
> 
> that would be more clean.

Can you just forward the proper version of this patch to me, as it seems
there are lots of different versions of this change floating around?

thanks,

greg k-h
