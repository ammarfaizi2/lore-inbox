Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbTBPAC2>; Sat, 15 Feb 2003 19:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTBPAC2>; Sat, 15 Feb 2003 19:02:28 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:15879 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S265096AbTBPAC1>;
	Sat, 15 Feb 2003 19:02:27 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.61-mm1
References: <20030214231356.59e2ef51.akpm@digeo.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20030214231356.59e2ef51.akpm@digeo.com>
Date: 15 Feb 2003 19:12:13 -0500
Message-ID: <m365rlf5ia.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried 2.5.61 and 2.5.61-mm1 on a dell inspiron 8100.

2.5.61 is working OK, but -mm1 hung as soon as it tried to exec init.
init=/bin/bash showed the same failure.

init(8) was able to print out it's first line, announcing its version
but then stopped.  with init=/bin/bash bash did not output anything.

-JimC



