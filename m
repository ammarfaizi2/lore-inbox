Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbVLFTZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbVLFTZP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbVLFTZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:25:15 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:22409 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030199AbVLFTZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:25:14 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Gerst <bgerst@didntduck.org>, Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1133894575.4136.171.camel@baythorne.infradead.org>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <20051205121851.GC2838@holomorphy.com>
	 <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org>
	 <20051206030828.GA823@opteron.random>  <4394696B.6060008@didntduck.org>
	 <1133894575.4136.171.camel@baythorne.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Dec 2005 19:23:55 +0000
Message-Id: <1133897035.23610.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-06 at 18:42 +0000, David Woodhouse wrote:
> There's some work on reverse-engineering the BIOS so that you can
> hackishly poke 'new' modes into its tables, but it's still not a very
> good option.

Especially as the BIOS interface at the low level for the analogue end
and the logic driving it is board specific. Intel have been fairly clear
why they use the BIOS interface.

