Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422675AbWJ3WBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWJ3WBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 17:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbWJ3WBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 17:01:17 -0500
Received: from ns2.suse.de ([195.135.220.15]:4827 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422675AbWJ3WBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 17:01:16 -0500
From: Neil Brown <neilb@suse.de>
To: "Andreas Paulsson" <andreas.paulsson@itgarden.se>
Date: Tue, 31 Oct 2006 09:01:02 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17734.30238.570920.973892@cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: raid5 just dies
In-Reply-To: message from Andreas Paulsson on Monday October 30
References: <6FDE26082D451C41BE1A3742966200B3B51C66@DR2EX01.hosting.itg>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 30, andreas.paulsson@itgarden.se wrote:
> [1.] One line summary of the problem:
> Raid5 just dies
> 
...
> 
> [3.] Keywords (i.e., modules, networking, kernel):
> raid5, aes-loop, kernel
> 

Exactly how are aes-loop and raid5 connected together?
Is the loop above the raid5 or below?
A precise description of how things are arranged would help.
A copy of /proc/mdstat would be good to.

Thanks,
NeilBrown
