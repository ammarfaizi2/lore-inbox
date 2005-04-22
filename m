Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVDVP5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVDVP5v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbVDVP4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:56:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:18856 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262039AbVDVPz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:55:57 -0400
Date: Fri, 22 Apr 2005 17:55:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-01
Message-ID: <20050422155549.GB22795@elte.hu>
References: <20050422154931.GA22534@elte.hu> <Pine.LNX.4.44.0504220852310.22042-100000@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0504220852310.22042-100000@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> What command line did you use ?
> 
> ./test --samples 10000 --hertz 128 --tasks 0

i used:

  ./test --tasks 10 file.hist

	Ingo
