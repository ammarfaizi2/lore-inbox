Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbUASVJL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 16:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbUASVJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 16:09:11 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:31128 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263462AbUASVJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 16:09:08 -0500
Date: Mon, 19 Jan 2004 15:04:52 -0500
From: Ben Collins <bcollins@debian.org>
To: Bob Gill <gillb4@telusplanet.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scsi devices not found
Message-ID: <20040119200452.GM473@phunnypharm.org>
References: <1074545082.18958.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074545082.18958.9.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 01:44:43PM -0700, Bob Gill wrote:
> Hi.  I was able to attach two firewire devices to 2.6.1-bk2, but with
> 2.6.1-bk4 and 2.6.1-bk5 they cannot be found (and they really are still
> attached).  gscanbus cannot find them (nor can /proc/partitions or
> /proc/scsi/scsi).  gscanbus reports:

I have this fixed in my tree. Just waiting on Linus or Andrew to pull
the two fixes in. If you can't wait, get the trunk from our SVN repo on
www.linux1394.org.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
