Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265948AbUAPX5y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 18:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265950AbUAPX5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 18:57:54 -0500
Received: from p50821B7E.dip.t-dialin.net ([80.130.27.126]:43911 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S265948AbUAPX5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 18:57:53 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug 1895] New: oops on test_wp_bit
References: <1eLgj-8fz-7@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 17 Jan 2004 00:57:42 +0100
In-Reply-To: <1eLgj-8fz-7@gated-at.bofh.it> (Martin J. Bligh's message of
 "Sat, 17 Jan 2004 00:10:07 +0100")
Message-ID: <m3isjbzbt5.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> http://bugme.osdl.org/show_bug.cgi?id=1895
>
>            Summary: oops on test_wp_bit
>     Kernel Version: 2.6.1-bk4, 2.6.1-mm4, 2.6.1

The -funit-at-a-time patch was applied without  the sort extables patch.
I believe Andrew fixed it already.

-Andi
