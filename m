Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264641AbUFGQlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264641AbUFGQlP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 12:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbUFGQlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 12:41:14 -0400
Received: from zero.aec.at ([193.170.194.10]:15364 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264641AbUFGQlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 12:41:09 -0400
To: <ingo@pyrillion.org>
cc: j.dittmer@portrix.net, linux-kernel@vger.kernel.org
Subject: Re: new icc kernel patch available (with kernel PGO)
References: <24uHQ-6XR-49@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 07 Jun 2004 18:40:50 +0200
In-Reply-To: <24uHQ-6XR-49@gated-at.bofh.it> (ingo@pyrillion.org's message
 of "Mon, 07 Jun 2004 18:00:22 +0200")
Message-ID: <m3fz972uel.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<ingo@pyrillion.org> writes:

> I published some preliminary results in the German Linux Magazine, which
> are copyrighted now. Sorry.
> Some hints: maximum performance gain approx. 40%, avg. perf. gain:
> approx. 8%; computed by LMBench+OProfile (accurate CPU cycle
> measurement, 10us timer resolution).

These were with profiling feedback, right? What training set did
you use for it?

-Andi

