Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266890AbUGVR6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266890AbUGVR6C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 13:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUGVR5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 13:57:40 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.20.8]:33164 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266872AbUGVRzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 13:55:00 -0400
Date: Thu, 22 Jul 2004 19:54:57 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: voluntary-preempt I0: sluggish feel
Message-ID: <20040722175457.GA5855@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
References: <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721183010.GA2206@yoda.timesys> <20040721210051.GA2744@yoda.timesys> <20040721211826.GB30871@elte.hu> <20040721223749.GA2863@yoda.timesys> <20040722100657.GA14909@elte.hu> <20040722160055.GA4837@ss1000.ms.mff.cuni.cz> <20040722161941.GA23972@elte.hu> <20040722172428.GA5632@ss1000.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722172428.GA5632@ss1000.ms.mff.cuni.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OTOH, now the system feels terribly slow when voluntary_preemption is set to 2.
> Setting it to 0 or 1 makes the sluggish feel go away.

Oh, sorry for the noise. It was the NVIDIA driver. The open one works much
better with the I0 patch.

Actually, it feels *GREAT*.

Sorry again. Have a nice day.

Rudo.
