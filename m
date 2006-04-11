Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWDKAIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWDKAIg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 20:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWDKAIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 20:08:36 -0400
Received: from ns1.suse.de ([195.135.220.2]:27867 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932245AbWDKAIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 20:08:35 -0400
From: Neil Brown <neilb@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Date: Tue, 11 Apr 2006 10:08:07 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17466.62311.155274.454051@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] drivers/md/md.c: make md_print_devices() static
In-Reply-To: message from Adrian Bunk on Tuesday April 11
References: <20060410222024.GL2408@stusta.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday April 11, bunk@stusta.de wrote:
> This patch makes the needlessly global md_print_devices() static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Looks good, thanks.  It'll be in my next batch to Andrew.

NeilBrown
