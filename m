Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265651AbUBJGQa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 01:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265652AbUBJGQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 01:16:30 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:30383 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S265651AbUBJGQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 01:16:29 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Tue, 10 Feb 2004 17:15:11 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16424.30447.392816.714983@notabene.cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 4.1GB limit with nfs3, 2.6 & knfsd?
In-Reply-To: message from Mike Fedyk on Monday February 9
References: <20040210043926.GG18674@srv-lnx2600.matchmail.com>
	<20040209215020.60cf2f93.akpm@osdl.org>
	<16424.29172.314124.933554@notabene.cse.unsw.edu.au>
	<20040210060826.GH18674@srv-lnx2600.matchmail.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday February 9, mfedyk@matchmail.com wrote:
> > 
> > This is probably fixed by the following patch that is sitting in my
> > queue.
....
> 
> Would this patch work with 2.6.1-bk2-nfs-stale-file-handles, or does it
> depend on any other patches?

It doesn't depend on, or conflict with, any other patches (to my
knowledge).

NeilBrown
