Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272120AbTHKGEp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 02:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272139AbTHKGEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 02:04:44 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:15298 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S272120AbTHKGEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 02:04:43 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Malcolm Smith <msmith@operamail.com>
Date: Mon, 11 Aug 2003 16:04:29 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16183.12781.571646.29277@gargle.gargle.HOWL>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS server issues
In-Reply-To: message from Malcolm Smith on Monday August 11
References: <3F372F68.99C02861@operamail.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday August 11, msmith@operamail.com wrote:
> I'm having trouble with 2.6.0-test2's NFS support.  The problem has
> existed for a few releases (not sure how far back.)
> 
> I'm using NFSv3 over UDP.  Every time a client makes an NFS mount, the
> previous mount is silently dropped.  The client assumes that both mounts
> are current, but only the more recent mount is functional.
> 
> Is this behaviour intentional?  Has anybody else experienced it?  2.4.x
> is not affected.

I'm afraid I don't quite understand your problem.
Could you be a bit more specific, and give examples?

Thanks,

NeilBrown
