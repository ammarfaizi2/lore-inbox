Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUDNXoE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbUDNXiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 19:38:18 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:43952 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261976AbUDNXeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 19:34:22 -0400
Date: Wed, 14 Apr 2004 16:45:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: haiquy@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.5-mjb1 Comment.
Message-ID: <166840000.1081986354@flay>
In-Reply-To: <Pine.LNX.4.53.0404150815250.654@linuxcd>
References: <Pine.LNX.4.53.0404150815250.654@linuxcd>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Test 2.6.5-mjb2 for more than 2 days only, system is pretty stable (the same as
> almost all other 2.6.x with my box). The significant performance improved
> compared to 2.6.5-aa5, 2.6.5 and all others 2.6.x for with a low end box line mine
> (660 Mhx Celeron 256 Mb RAM) make me write this comment. :-) Wish that some
> improvement could make way to the mainline kernel.

Good ;-) We're working on getting it integrated back in ... just a couple of
outstanding corner cases need killing first.
 
> The memory management is nearly perfect. Before I tried one ck kernel use auto
> regulation swap and it was still much worse than this one as I noticed the value
> in swappiness also changes by the time.

Con's changes are in there, but they were updated once or twice, and there
are bug fixes too. I still think it's the Right Thing to Do (tm).

M.

