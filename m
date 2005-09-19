Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbVISSS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbVISSS2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVISSS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:18:28 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35527
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932520AbVISSS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:18:27 -0400
Date: Mon, 19 Sep 2005 11:18:36 -0700 (PDT)
Message-Id: <20050919.111836.95468371.davem@davemloft.net>
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [TG3]: Add AMD K8 to list of write-reorder chipsets.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1127132518.3019.8.camel@localhost.localdomain>
References: <200509182159.j8ILxdDB030369@hera.kernel.org>
	<1127132518.3019.8.camel@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjanv@redhat.com>
Date: Mon, 19 Sep 2005 08:21:58 -0400

> shouldn't something like this move to generic code?
> (and in this case, probably as quirk that disables the chipset
> "feature" ?)

In the long term yes, but the latter part of your suggestion is
assuming this is something that can be controlled and isn't just some
chipset bug.
