Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261718AbTCaQaE>; Mon, 31 Mar 2003 11:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261719AbTCaQaD>; Mon, 31 Mar 2003 11:30:03 -0500
Received: from dp.samba.org ([66.70.73.150]:46788 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261718AbTCaQ37>;
	Mon, 31 Mar 2003 11:29:59 -0500
Date: Tue, 1 Apr 2003 02:36:38 +1000
From: Anton Blanchard <anton@samba.org>
To: "David S. Miller" <davem@redhat.com>
Cc: sfr@canb.auug.org.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       randolph@tausq.org, bcrl@redhat.com
Subject: Re: [PATCH][COMPAT] another net/compat fix -- for recvmsg
Message-ID: <20030331163637.GB28986@krispykreme>
References: <20030331181644.29a2bfc6.sfr@canb.auug.org.au> <20030331.051718.111107720.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030331.051718.111107720.davem@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I believe all are totally correct, patch applied.
> 
> Anton, please check to make sure this fixes your sshd problems
> on ppc64, thanks.

Nice work, it does fix the ssh problems (ie broken FD passing).

Anton
