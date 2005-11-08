Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965356AbVKHDY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965356AbVKHDY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965349AbVKHDY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:24:59 -0500
Received: from cantor2.suse.de ([195.135.220.15]:20188 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965343AbVKHDY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:24:57 -0500
From: Neil Brown <neilb@suse.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Date: Tue, 8 Nov 2005 14:24:33 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17264.6769.472245.973213@cse.unsw.edu.au>
Cc: Al Viro <viro@ftp.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Subject: Re: [OT] Re: [PATCH 3/18] allow callers of seq_open do allocation
 themselves
In-Reply-To: message from Randy.Dunlap on Monday November 7
References: <E1EZInj-0001Eh-9T@ZenIV.linux.org.uk>
	<20051107190340.129bc8c3.rdunlap@xenotime.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 7, rdunlap@xenotime.net wrote:
> On Tue, 08 Nov 2005 02:01:31 +0000 Al Viro wrote:
> 
> > From: Al Viro <viro@zeniv.linux.org.uk>
> > Date: 1131401734 -0500
> 
> What format is that date in, please?
> 

 %s %z

(as date(1) understands it).

Or was this a rhetorical question, meaning to say "Who in their right
mind would used that sort of date format on a public mailing list?" :-)

NeilBrown
