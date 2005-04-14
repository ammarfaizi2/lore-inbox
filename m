Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVDNSMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVDNSMq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 14:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVDNSLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 14:11:50 -0400
Received: from ns.suse.de ([195.135.220.2]:7908 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261583AbVDNSLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 14:11:34 -0400
Date: Thu, 14 Apr 2005 20:11:33 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@redhat.com>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
Message-ID: <20050414181133.GA18221@wotan.suse.de>
References: <20050330214455.GF10159@redhat.com> <20050331104117.GD1623@wotan.suse.de> <20050407024902.GA9017@redhat.com> <20050407062928.GH24469@wotan.suse.de> <Pine.LNX.4.61.0504141419250.25074@goblin.wat.veritas.com> <20050414170117.GD22573@wotan.suse.de> <Pine.LNX.4.61.0504141804480.26008@goblin.wat.veritas.com> <20050414181015.GH22573@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414181015.GH22573@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I will take a closer look at the rc1/rc2 patches later this evening
> and see if I can spot something. Can only report back tomorrow though.

Actually itt started in .11 already - sigh - on rereading the thread.
That will make the code audit harder :/

-Andi
