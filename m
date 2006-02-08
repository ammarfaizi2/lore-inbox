Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWBHWMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWBHWMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 17:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWBHWMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 17:12:15 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2793
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932098AbWBHWMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 17:12:13 -0500
Date: Wed, 08 Feb 2006 14:12:05 -0800 (PST)
Message-Id: <20060208.141205.129707967.davem@davemloft.net>
To: jesse.brandeburg@gmail.com
Cc: yoseph.basri@gmail.com, bb@kernelpanic.ru, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: KERNEL: assertion (!sk->sk_forward_alloc) failed
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4807377b0602081207s7604eceahb8bf4af6715a6534@mail.gmail.com>
References: <e282236e0602070146p1ed3fdb6k74aa75e15bbc37a3@mail.gmail.com>
	<4807377b0602081207s7604eceahb8bf4af6715a6534@mail.gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Date: Wed, 8 Feb 2006 12:07:14 -0800

> this should be on netdev (cc'd), i included some of the thread here.
 ...
> I though Herbert had fixed these, and it looks like half the patches
> got into 2.6.14.3, but not the fix to the fix committed on 9-6 (not in
> 2.6.14.* at all)

What are the changeset IDs so I can fix this?

Thanks.
