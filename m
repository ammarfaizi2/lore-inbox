Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVCNUoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVCNUoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 15:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVCNUoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 15:44:44 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:35051 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261900AbVCNUon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 15:44:43 -0500
Date: Mon, 14 Mar 2005 15:44:41 -0500
From: Andreas Dilger <adilger@clusterfs.com>
To: John Kacur <jkacur@rogers.com>, kai.germaschewski@unh.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Exuberant ctags can tag files names too
Message-ID: <20050314204441.GG1451@schnapps.adilger.int>
Mail-Followup-To: John Kacur <jkacur@rogers.com>,
	kai.germaschewski@unh.edu, linux-kernel@vger.kernel.org
References: <1110420068.5526.39.camel@linux.site> <20050314200900.GC17373@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050314200900.GC17373@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 14, 2005  21:09 +0100, Sam Ravnborg wrote:
> I already applied your original patch (end of January) but only this week
> it hit Linus' tree.
> I think ctags users will just upgrade if their ctgs does not support
> --extra=+f.

I have ctags-5.4.2 (24 Jan 2003) and it has the --extra=+f support, so
I doubt it will hurt many people to make it default.

Cheers, Andreas
--
Andreas Dilger
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/

