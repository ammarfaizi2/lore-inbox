Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268162AbUIFPyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268162AbUIFPyI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 11:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268164AbUIFPyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 11:54:08 -0400
Received: from host-83-146-9-72.bulldogdsl.com ([83.146.9.72]:31772 "EHLO
	host-83-146-9-72.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S268162AbUIFPyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 11:54:05 -0400
Message-ID: <1094486042.413c881a748ee@unsolicited.net>
Date: Mon,  6 Sep 2004 16:54:02 +0100
From: David R <spam.david.trap@unsolicited.net>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com, akpm@osdl.org
Subject: Re: PATCH: Misrouted IRQ recovery, take 2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox <alan@redhat.com>:

I'm probably being stupid...  but in misrouted_irq(), shouldn't the 'work' flag
be reset for each irq, rather than initialised outside the main loop?

David
