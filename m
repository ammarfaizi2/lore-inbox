Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262800AbVDAXiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbVDAXiC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 18:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVDAXiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 18:38:01 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:56498 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262800AbVDAXh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:37:56 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Antti Salmela <asalmela@iki.fi>
Date: Sat, 2 Apr 2005 09:37:07 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16973.56100.413874.917027@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-lvm@redhat.com
Subject: Re: 2.6.11ac5 oops while reconstructing md array and moving volumegroup with pvmove
In-Reply-To: message from Antti Salmela on Friday April 1
References: <20050401143853.GA11763@asalmela.iki.fi>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday April 1, asalmela@iki.fi wrote:
> I had created a new raid1 array and started moving a volume group to it at the
> same time while it was reconstructing. Got this oops after several hours,

The subject says 'md array' but the Opps seems to say 'dm raid1
array'.

Could you please clarify exactly what the configuration is.

Thanks,
NeilBrown

