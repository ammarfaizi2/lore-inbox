Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUDSVGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUDSVGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 17:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUDSVGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 17:06:32 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:7311 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261857AbUDSVGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 17:06:31 -0400
Date: Mon, 19 Apr 2004 15:06:28 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [RFT] Ext3 online resize for 2.6.6-rc1
Message-ID: <20040419210628.GN12357@schnapps.adilger.int>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	"ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
References: <1082407133.2237.87.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082407133.2237.87.camel@sisko.scot.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 19, 2004  21:38 +0100, Stephen C. Tweedie wrote:
> I'll do a proper 1.1.19 release of sourceforge ext2resize once I work
> out just how the sourceforge CVS tree needs to be put together. 
> Andreas, is it really deliberate that you've got both the input and
> output autoconf files (eg. Makefile and Makefile.in) under CVS control
> for ext2resize?

I didn't set up the autoconf stuff initially, and I think I kept the
generated Makefile for people that didn't have autoconf on their systems.
Feel free to cleanup/slash/burn as you want.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

