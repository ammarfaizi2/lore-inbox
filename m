Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWHAWMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWHAWMT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 18:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWHAWMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 18:12:19 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:3485
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751241AbWHAWMR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 18:12:17 -0400
Date: Tue, 01 Aug 2006 15:12:11 -0700 (PDT)
Message-Id: <20060801.151211.88703025.davem@davemloft.net>
To: omar.aitmous@gmail.com
Cc: linux-kernel@vger.kernel.org, jp@enix.org, sebastien.wacquiez@enix.fr,
       smagghue@gmail.com, risk_colta@hotmail.com
Subject: Re: Connection tracking synchronization module
From: David Miller <davem@davemloft.net>
In-Reply-To: <e084545e0608010617h9941cbchd366cf3ee6bcb0d0@mail.gmail.com>
References: <e084545e0608010617h9941cbchd366cf3ee6bcb0d0@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Omar Aït Mous" <omar.aitmous@gmail.com>
Date: Tue, 1 Aug 2006 15:17:27 +0200

> This is a kernel module to allow real-time synchronization of connection
> tracking tables between two linux routers.

You might want to send this to the netfilter developer list, not here.
Also, the netfilter netlink channels already in the kernel are meant
to be a means by which synchronization could be implemented.

But please discuss this on the netfilter developer list, which is at:
netfilter-devel@lists.netfilter.org

Thanks.
