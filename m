Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVAEGTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVAEGTj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 01:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVAEGTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 01:19:39 -0500
Received: from main.gmane.org ([80.91.229.2]:64673 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262262AbVAEGTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 01:19:38 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: starting with 2.7
Date: Wed, 05 Jan 2005 11:20:49 +0500
Message-ID: <crg0ti$aes$1@sea.gmane.org>
References: <200501032059.j03KxOEB004666@laptop11.inf.utfsm.cl> <0F9DCB4E-5DD1-11D9-892B-000D9352858E@mac.com> <Pine.LNX.4.61.0501031648300.25392@chimarrao.boston.redhat.com> <5B2E0ED4-5DD3-11D9-892B-000D9352858E@mac.com> <20050103221441.GA26732@infradead.org> <20050104054649.GC7048@alpha.home.local> <20050104063622.GB26051@parcelfarce.linux.theplanet.co.uk> <9F909072-5E3A-11D9-A816-000D9352858E@mac.com> <Pine.LNX.4.61.0501040735410.25392@chimarrao.boston.redhat.com> <85546E06-5E50-11D9-A816-000D9352858E@mac.com> <20050104200912.GA22075@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inet.ycc.ru
User-Agent: KNode/0.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:

> Anyway, when you manage your own distribution, you have no other solution
> than reading lkml daily (better: continuously) to grab the required fixes
> and apply them to your local tree. If you feel that sometime you won't be
> able to do the backport, either you can ask on lkml, people are often
> willing to help, or you need to rely on other people's work (read distro
> kernels).

I agree to rely on other people's work, but not _random_ distro kernels. The
reason is that distros usually both fix bugs and test new features on their
users.

What's needed is an equivalent of linux-libc-headers: a vendor-neutral
generally-accepted kernel usable as-is in most cases.

-- 
Alexander E. Patrakov

