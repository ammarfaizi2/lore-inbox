Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267362AbUI0WAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267362AbUI0WAm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 18:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUI0WAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 18:00:42 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:2119 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S267362AbUI0WAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 18:00:41 -0400
Subject: Re: 2.6.9-rc2-mm4
From: Paul Fulghum <paulkf@microgate.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040927211412.GA24232@elte.hu>
References: <20040926181021.2e1b3fe4.akpm@osdl.org>
	 <200409270053.22911.gene.heskett@verizon.net>
	 <20040927201928.GB19257@elte.hu>
	 <1096317273.2523.5.camel@deimos.microgate.com>
	 <20040927211412.GA24232@elte.hu>
Content-Type: text/plain
Message-Id: <1096322436.2563.1.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 27 Sep 2004 17:00:36 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 16:14, Ingo Molnar wrote:
> ok, could you re-enable bkl preemption but also enable SCHED_SMT - does
> that fix the hang too?

Now that my hamster powered machine 
(dual hamsters actually)
has *finally* finished compiling...

Having both options enabled does allow
the machine to boot properly.

-- 
Paul Fulghum
paulkf@microgate.com

