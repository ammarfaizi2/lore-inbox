Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966193AbWKNQsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966193AbWKNQsx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966205AbWKNQsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:48:53 -0500
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:46979 "EHLO
	aa012msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S966193AbWKNQsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:48:52 -0500
Date: Tue, 14 Nov 2006 17:44:51 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Adrian Bunk <bunk@stusta.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [discuss] 2.6.19-rc5: known regressions (v2)
Message-ID: <20061114174451.4afc9b6a@localhost>
In-Reply-To: <20061111132929.56c4539e@localhost>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<200611111008.37986.rjw@sisk.pl>
	<20061111102506.5f98688c@localhost>
	<200611111149.27370.rjw@sisk.pl>
	<20061111132929.56c4539e@localhost>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2006 13:29:29 +0100
Paolo Ornati <ornati@fastwebnet.it> wrote:

> > Okay, please let us know if it survives the next several cycles.
> > 
> > OTOH, the problem may be hiding.
> 
> Ok, and if it survives againg and again I can do a partial bisection...

"-rc5" is still alive: 6 days of uptime using suspend/resume many times
every day...

so if the problem is there it's hiding very well.


Now I'll slowly go back with older kernels and see what happens...

-- 
	Paolo Ornati
	Linux 2.6.19-rc5 on x86_64
