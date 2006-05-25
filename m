Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWEYHPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWEYHPb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 03:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWEYHPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 03:15:31 -0400
Received: from mx1.suse.de ([195.135.220.2]:49811 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964947AbWEYHPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 03:15:30 -0400
From: Neil Brown <neilb@suse.de>
To: "Xin Zhao" <uszhaoxin@gmail.com>
Date: Thu, 25 May 2006 17:15:19 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17525.22919.839145.328814@cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Where can I find the source code of rpc.mountd?
In-Reply-To: message from Xin Zhao on Thursday May 25
References: <4ae3c140605250006w6fb5a165t83124dda96ea8c21@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday May 25, uszhaoxin@gmail.com wrote:
> I need to read the working flow of rpc.mountd for developing a file
> system. However, I cannot find the source code. Can someone tell me
> where I can get the source code of rpc.mountd?

In the nfs-utils product which is maintained in the 'nfs' project on
sourceforge.
Start at http://nfs.sourceforge.net/

NeilBrown
 
