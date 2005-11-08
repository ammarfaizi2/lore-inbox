Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbVKHDDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbVKHDDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVKHDDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:03:06 -0500
Received: from cantor2.suse.de ([195.135.220.15]:42714 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030269AbVKHDDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:03:03 -0500
From: Neil Brown <neilb@suse.de>
To: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 8 Nov 2005 14:02:51 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17264.5467.78557.38472@cse.unsw.edu.au>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, linuxram@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/18] make /proc/mounts pollable
In-Reply-To: message from Al Viro on Tuesday November 8
References: <E1EZInj-0001Ej-9n@ZenIV.linux.org.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ahh, now this is interesting.
I tried to make /proc/mdstat pollable some time ago and go howled down
as it was said to be the Wrong Thing(TM). (It was not, I hasten to
add, Al who howled me down).

I look forward to seeing the progress of this patch.

I wonder if there is any chance of attributes in sysfs being pollable
too??

NeilBrown
