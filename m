Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbTLHRVt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbTLHRVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:21:49 -0500
Received: from holomorphy.com ([199.26.172.102]:59867 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265030AbTLHRVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:21:48 -0500
Date: Mon, 8 Dec 2003 09:21:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Kanar <mkanarlists@kanar.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
Message-ID: <20031208172145.GM14258@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Kanar <mkanarlists@kanar.net>, linux-kernel@vger.kernel.org
References: <ZAwx-88m-3@gated-at.bofh.it> <ZAGd-8ma-5@gated-at.bofh.it> <ZAQ7-6X-13@gated-at.bofh.it> <ZAZB-pS-11@gated-at.bofh.it> <ZCoI-2oz-9@gated-at.bofh.it> <ZCyh-2Bv-1@gated-at.bofh.it> <ZCI5-2Pv-3@gated-at.bofh.it> <ZCIb-2Pv-11@gated-at.bofh.it> <3FD4AA11.6010806@kanar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD4AA11.6010806@kanar.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 11:42:57AM -0500, Matthew Kanar wrote:
> Here is one of my SMP systems (Dell-Dual P3), although noirqbalance 
> doesn't seem to change things --
> uname -nrvm:
> k12.kanar.net 2.6.0-test11 #2 SMP Wed Dec 3 18:50:36 EST 2003 i686
> _Without_ noirqbalance -
> uptime:
>  10:31:51  up 4 days, 15:07, 10 users,  load average: 0.00, 0.02, 0.00

ACPI may be doing something strange (as usual). It looks like you somehow
got slammed into fixed delivery mode.


-- wli
