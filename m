Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUEVVmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUEVVmz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 17:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUEVVmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 17:42:55 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:31688 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261925AbUEVVmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 17:42:54 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Jim Gifford" <maillist@jg555.com>
Date: Sun, 23 May 2004 07:42:34 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16559.51530.676312.49328@cse.unsw.edu.au>
Cc: "Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Trouble with NFS with -mm3, -mm4, and -mm5
In-Reply-To: message from Jim Gifford on Saturday May 22
References: <01ef01c44027$7cb90920$d100a8c0@W2RZ8L4S02>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday May 22, maillist@jg555.com wrote:
> I keep getting the following oops using NFS with -mm3 thru -mm5.

What filesystem type(s) are you exporting?

NeilBrown

> 
> May 22 00:25:27 server ------------[ cut here ]------------
> May 22 00:25:27 server kernel BUG at include/linux/dcache.h:276!
> May 22 00:25:27 server invalid operand: 0000 [#1]
> May 22 00:25:27 server PREEMPT SMP
