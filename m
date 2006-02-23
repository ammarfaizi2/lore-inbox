Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751662AbWBWIut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbWBWIut (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 03:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbWBWIut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 03:50:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37531 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751659AbWBWIus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 03:50:48 -0500
Subject: Re: Red Hat ES4 GPL Issues?
From: Arjan van de Ven <arjan@infradead.org>
To: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43FCFDC6.9090109@soleranetworks.com>
References: <43FCFDC6.9090109@soleranetworks.com>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 09:50:46 +0100
Message-Id: <1140684646.2972.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 17:11 -0700, Jeff V. Merkey wrote:
> I have been working on 2.6.9 kernels with red hat ES4 series 
> distributions (we purchased and have a license).  I noticed that the ES4 
> series kernels
> which support NPTL libs no longer provide the source code with the 
> distribution (the installed kernels sources point to empty source trees 
> which
> only contain makefiles).   I have discovered we have to use our Red Hat 
> Network account in order to download the Source RPMs
> (which are in fact provided).
> 
> We got the distro via electronic fullfilment, so we did not get the 
> SRPMS CD iso images by default.  

that sounds wrong; these ISOs are just there as well for download where
you downloaded the binary ones. 


> I am curious if Red Hat views requiring people subscribing to RHN as a 
> requirement to obtain source code is in conflict with the GPL. 

I doubt they do; you need the same subscription to get the binaries in
the first place, and when you get the binaries the sources are in the
same location. For all intents and purposes that is "sources come with
the binaries". If you select to be cheap and only download half, that's
your problem ;-)


In addition, Red Hat also publishes the src.rpms on their FTP site, even
though the GPL does not require them to do so. But just to be nice. 


I think you're talking out of the place the sun don't shine this time
sir ;-)


