Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752222AbWCJK7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbWCJK7M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 05:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWCJK7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 05:59:12 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:63664
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752221AbWCJK7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 05:59:10 -0500
Date: Fri, 10 Mar 2006 02:59:12 -0800 (PST)
Message-Id: <20060310.025912.107001339.davem@davemloft.net>
To: imcdnzl@gmail.com
Cc: bb@kernelpanic.ru, jesse.brandeburg@gmail.com, yoseph.basri@gmail.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: KERNEL: assertion (!sk->sk_forward_alloc) failed
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <cbec11ac0602091137p4ee233bdgdcfbf3d6cb62a62f@mail.gmail.com>
References: <cbec11ac0602091125w5a5a7c6em8462131e9f9b24dc@mail.gmail.com>
	<43EB98B0.4@kernelpanic.ru>
	<cbec11ac0602091137p4ee233bdgdcfbf3d6cb62a62f@mail.gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian McDonald <imcdnzl@gmail.com>
Date: Fri, 10 Feb 2006 08:37:48 +1300

> On 2/10/06, Boris B. Zhmurov <bb@kernelpanic.ru> wrote:
> > Hello, Ian McDonald.
> >
> > On 09.02.2006 22:25 you said the following:
> >
> > > Is it possible for you to download 2.6.16-rc2 or similar and see if it
> > > goes away?
> >
> > It'll be better, if I get only patch fixs that problem, not all 2.6.16-rc2.
>
> Oops I didn't read Jesse's message earlier properly.
> 
> That patch which probably fixed it is (from his message):
> I think the commit id that is missing from 2.6.14.X is
> fb5f5e6e0cebd574be737334671d1aa8f170d5f3

This patch is in the linux-2.6.14 stable tree, I just
verified this.
