Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267238AbUHDCbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267238AbUHDCbd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267235AbUHDCbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:31:32 -0400
Received: from holomorphy.com ([207.189.100.168]:55480 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267250AbUHDCb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:31:26 -0400
Date: Tue, 3 Aug 2004 19:31:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040804023120.GK2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
	Chris Wright <chrisw@osdl.org>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20040804021332.GT2241@dualathlon.random> <Pine.LNX.4.44.0408032221310.5948-100000@dhcp83-102.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408032221310.5948-100000@dhcp83-102.boston.redhat.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 10:22:30PM -0400, Rik van Riel wrote:
> Please read my incremental patch.  It adds a quota check
> right after this code segment.

Actually, some of the confusion may be losing pieces of the incremental
patches (I'm certainly missing the full picture).

By any chance could you repost a complete patch and/or series?


-- wli
