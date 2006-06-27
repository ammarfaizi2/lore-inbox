Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWF0Axz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWF0Axz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 20:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWF0Axx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 20:53:53 -0400
Received: from cantor.suse.de ([195.135.220.2]:32447 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964793AbWF0Axv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 20:53:51 -0400
From: Neil Brown <neilb@suse.de>
To: David Howells <dhowells@redhat.com>
Date: Tue, 27 Jun 2006 10:53:26 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17568.33158.568708.859294@cse.unsw.edu.au>
Cc: balbir@in.ibm.com, akpm@osdl.org, aviro@redhat.com, jblunck@suse.de,
       dev@openvz.org, olh@suse.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Destroy the dentries contributed by a superblock on unmounting 
In-Reply-To: message from David Howells on Monday June 26
References: <17567.31035.471039.999828@cse.unsw.edu.au>
	<17566.12727.489041.220653@cse.unsw.edu.au>
	<17564.52290.338084.934211@cse.unsw.edu.au>
	<15603.1150978967@warthog.cambridge.redhat.com>
	<553.1151156031@warthog.cambridge.redhat.com>
	<20946.1151251352@warthog.cambridge.redhat.com>
	<18192.1151320860@warthog.cambridge.redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday June 26, dhowells@redhat.com wrote:
> 
> So here's a new version.
> 

Acked-by: NeilBrown <neilb@suse.de>

very nice, thanks.

NeilBrown

