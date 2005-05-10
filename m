Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVEJVGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVEJVGS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVEJVFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:05:45 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:33967 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261796AbVEJU7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:59:44 -0400
Date: Tue, 10 May 2005 13:59:51 -0700
From: Greg KH <gregkh@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050510205950.GB3634@suse.de>
References: <20050506212227.GA24066@kroah.com> <1115611034.14447.11.camel@localhost.localdomain> <20050509232103.GA24238@suse.de> <1115717357.10222.1.camel@localhost.localdomain> <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru> <20050510172447.GA11263@wonderland.linux.it> <20050510201355.GB3226@suse.de> <1115756904.14061.23.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115756904.14061.23.camel@mindpipe>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 04:28:24PM -0400, Lee Revell wrote:
> On Tue, 2005-05-10 at 13:13 -0700, Greg KH wrote:
> > Also, the blacklisting stuff should not be
> > that prevelant anymore...
> 
> It's quite often used by ALSA users who need to prevent hotplug from
> loading the OSS modules.  Is there a better way to do this?

Don't build the OSS modules at all?  :)

greg k-h
