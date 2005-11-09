Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVKIHhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVKIHhN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 02:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVKIHhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 02:37:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:24757 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751258AbVKIHhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 02:37:09 -0500
From: Neil Brown <neilb@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Date: Wed, 9 Nov 2005 18:37:02 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17265.42782.188870.907784@cse.unsw.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: userspace block driver?
In-Reply-To: message from Jeff Garzik on Wednesday November 9
References: <4371A4ED.9020800@pobox.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 9, jgarzik@pobox.com wrote:
> 
> Has anybody put any thought towards how a userspace block driver
> would work?

Isn't this was enbd does? 
  http://www.it.uc3m.es/~ptb/nbd/

NeilBrown
