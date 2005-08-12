Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVHLUib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVHLUib (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 16:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbVHLUib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 16:38:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:5815 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751264AbVHLUib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 16:38:31 -0400
Date: Fri, 12 Aug 2005 13:38:05 -0700
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@suse.de>
Cc: johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org
Subject: Re: w1: more debug level decrease.
Message-ID: <20050812203805.GA22693@kroah.com>
References: <20050812184622.GA19999@kroah.com.suse.lists.linux.kernel> <p737jeq3o8j.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p737jeq3o8j.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 10:16:12PM +0200, Andi Kleen wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > Here's a patch for 2.6.13-rc6 to keep people's syslogs a bit nicer.
> 
> But why is this thing running every 10 seconds at all in the first place?
> Looks to me like you're just hiding the symptoms, not fixing the bug
> that makes this code run on unsuspecting systems.
> 
> e.g. one way would be to only probe once and then never again. 

Don't know, Evgeniy?

greg k-h
