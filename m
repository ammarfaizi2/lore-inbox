Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269117AbUI2XRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269117AbUI2XRl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 19:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269120AbUI2XRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 19:17:41 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:20891 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S269117AbUI2XRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 19:17:38 -0400
Date: Wed, 29 Sep 2004 16:16:41 -0700
From: Stew Smith <stew.smith@sun.com>
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: linux-kernel@vger.kernel.org, autofs@linux.kernel.org, thockin@hockin.org,
       raven@themaw.net, mark.fasheh@oracle.com
Subject: Re: [announce] Autofs NG 0.1
Message-ID: <20040929231641.GC29260@crashy.west.sun.com>
Mail-Followup-To: Mike Waychison <Michael.Waychison@sun.com>,
	linux-kernel@vger.kernel.org, autofs@linux.kernel.org,
	thockin@hockin.org, raven@themaw.net, mark.fasheh@oracle.com
References: <4154C0F2.708@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4154C0F2.708@sun.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 08:50:58PM -0400, Mike Waychison wrote:
> 
> Hi folks,
> 
> Some of you may remember my posting of a new way to do autofs in Linux a
> while back:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107341940326348&w=2
> 
> Anyhow,  I've gotten to the point where I have code that people can play
> with.  I've posted it all at http://autofsng.bkbits.net
> 
> There are two repos located there, one is the userspace bits (autofsng).
> ~ It has the 'utility' (automount) and the autofs usermode agent
> (autofs).  This tree began as a automount 3.1.7 tree, but has
> drastically changed.  Lots of good stuff has yet to be merged in from
> the automount 4 daemon.
> 
> The kernel bits are in the linux-2.6-autofsng repository.   Broken out
> patches are forthcoming in the next (weeks?) [*].  It has the following
> major changes to it:

autofsng userland tarball and kernel patch can now be found
here for non-bitkeeper users:

ftp://ftp-eng.cobalt.com/pub/users/ssmith/autofsng/

thanks,

--
Stew Smith

