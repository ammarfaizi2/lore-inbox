Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264641AbTFLAcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 20:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbTFLAcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 20:32:50 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:34442 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264641AbTFLAct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 20:32:49 -0400
Date: Wed, 11 Jun 2003 17:19:31 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: boris@macbeth.rhoen.de, linux-kernel@vger.kernel.org
Subject: Re: oops while booting : 2.5.70-bk1[4,5] - Process swapper
Message-ID: <20030612001931.GB27815@kroah.com>
References: <20030610202947.GA752@macbeth.rhoen.de> <20030610143018.025d318c.akpm@digeo.com> <20030610165111.7911b7cb.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610165111.7911b7cb.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 04:51:11PM -0700, Andrew Morton wrote:
> 
> Greg, do you have time/inclination to untangle (and preferably document)
> this mess?

Ugh, what a mess.  Hm, no I don't really have the time right now to do
this, but possibly will after the rest of the pci changes are done...

As for documenting, why?  It's an arch specific thing that really does
not get touched very often, if at all.

thanks,

greg k-h
