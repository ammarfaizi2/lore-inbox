Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbWFIXsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbWFIXsW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbWFIXsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:48:22 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:13226 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030383AbWFIXsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:48:21 -0400
Message-ID: <448A08BF.10506@garzik.org>
Date: Fri, 09 Jun 2006 19:48:15 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
CC: Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <20060609195750.GD10524@thunk.org> <20060609203803.GF3574@ca-server1.us.oracle.com> <20060609210319.GF10524@thunk.org>
In-Reply-To: <20060609210319.GF10524@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> I suspect that Red Hat has learned from that past experience, and
> won't be making that mistake again, at least without explicitly
> requesting the user's permission.  So how about we trust the
> distributions to be a bit more careful this time around?

Make the line of demarcation much more clear...

	Jeff


