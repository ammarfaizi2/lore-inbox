Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbTILEsT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 00:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbTILEsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 00:48:19 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:39697
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261675AbTILEsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 00:48:16 -0400
Date: Thu, 11 Sep 2003 21:48:20 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiser3/4 & Ext2/3 was: First impressions of reiserfs4
Message-ID: <20030912044820.GG26618@matchmail.com>
Mail-Followup-To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
	linux-kernel@vger.kernel.org
References: <20030912005007.B11566@bitwizard.nl> <E19xcc1-0000mF-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19xcc1-0000mF-00@calista.inka.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 03:20:37AM +0200, Bernd Eckenfels wrote:
> In article <20030912005007.B11566@bitwizard.nl> you wrote:
> > at all. But no backup superblock, is just plain wrong. 
> 
> this totally depends on the capabilities of the fsck and in-kerlen journal
> replay code, if they can reconstruct the data in there.

And if you have no superblock how does it know where the journal is?
