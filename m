Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263890AbTKSPz3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 10:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTKSPz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 10:55:28 -0500
Received: from cap175-219-202.pixi.net ([207.175.219.202]:2432 "EHLO
	beaucox.com") by vger.kernel.org with ESMTP id S263890AbTKSPz2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 10:55:28 -0500
From: "Beau E. Cox" <beau@beaucox.com>
Organization: BeauCox.com
To: "David S. Miller" <davem@redhat.com>
Subject: Re: PROBLEM: 2.4.23-rc4 -> rc1 hang with change to ip_nat_core.c made in pre4
Date: Wed, 19 Nov 2003 05:55:22 -1000
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
References: <200311121442.27406.beau@beaucox.com> <20031112195908.0611fe2e.davem@redhat.com>
In-Reply-To: <20031112195908.0611fe2e.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311190555.22438.beau@beaucox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 November 2003 05:59 pm, David S. Miller wrote:
> Marcelo has reverted the change in question, so his current
> 2.4.x tree should be fine.

Thank you all for reverting the pre4 change to ip_nat_core.c that
was giving me problems.

I have 2.4.23-rc2 up and running fine.

Aloha => Beau;

