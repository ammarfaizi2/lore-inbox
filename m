Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUCaXdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 18:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbUCaXdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 18:33:43 -0500
Received: from mail.kroah.org ([65.200.24.183]:51078 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262079AbUCaXdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 18:33:41 -0500
Date: Wed, 31 Mar 2004 15:22:10 -0800
From: Greg KH <greg@kroah.com>
To: Linda Xie <lxiep@ltcfwd.linux.ibm.com.kroah.org>
Cc: Linda Xie <lxiep@linux.ibm.com.kroah.org>,
       John Rose <johnrose@austin.ibm.com>, gregkh@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: PATCH -- kobject_set_name() doesn't allocate enough space]
Message-ID: <20040331232207.GA4525@kroah.com>
References: <40649B96.7010503@ltcfwd.linux.ibm.com> <20040326223204.GA30729@kroah.com> <4064F242.10501@ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4064F242.10501@ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 09:17:22PM -0600, Linda Xie wrote:
> Greg KH wrote:
> 
> >On Fri, Mar 26, 2004 at 03:07:34PM -0600, Linda Xie wrote:
> > 
> >
> >>Hi Linus,
> >>
> >>
> >>Please see attached patch at the end of FW mail and apply it to your tree.
> >>   
> >>
> >
> >Your patch is munged again and will not apply :(
> >
> >Can you send me a new version?  I'll apply it to my tree and let it get
> >tested in the -mm tree before sending it on to Linus.

> Sounds good.  See below for the patch. If it doesn't work, try the 
> attachement.

The attachment worked, I've applied it to my trees and will forward it
on.

thanks,

greg k-h
