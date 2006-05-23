Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWEWGGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWEWGGL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 02:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWEWGGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 02:06:11 -0400
Received: from mail.suse.de ([195.135.220.2]:65203 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751354AbWEWGGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 02:06:10 -0400
From: Neil Brown <neilb@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Date: Tue, 23 May 2006 16:05:29 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17522.42537.1470.457164@cse.unsw.edu.au>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4 md lock held at task exit 
In-Reply-To: message from Keith Owens on Tuesday May 23
References: <17508.13583.730399.209905@cse.unsw.edu.au>
	<9193.1148363807@kao2.melbourne.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday May 23, kaos@ocs.com.au wrote:
> 
> Finally got some time to test this.  The problem was reproducable and
> the patch fixed it.
> 
> Acked-by: Keith Owens <kaos@ocs.com.au>

Thanks.  I'll make sure it goes in.

NeilBrown
