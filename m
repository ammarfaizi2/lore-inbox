Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1766645AbWJUSWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766645AbWJUSWf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766642AbWJUSWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:22:35 -0400
Received: from ns.suse.de ([195.135.220.2]:60587 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1766643AbWJUSWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:22:34 -0400
From: Andi Kleen <ak@suse.de>
To: patches@x86-64.org
Subject: Re: [patches] Re: [PATCH] [14/19] i386: Disable nmi watchdog on all ThinkPads
Date: Sat, 21 Oct 2006 20:22:22 +0200
User-Agent: KMail/1.9.5
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <20061021651.356252000@suse.de> <200610212011.56215.ak@suse.de> <20061021181440.GG30758@redhat.com>
In-Reply-To: <20061021181440.GG30758@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610212022.22911.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ouch, nasty.  I'm surprised no-one complained about this earlier.

i386 only enabled it post 2.6.18. I suppose nobody tested ThinkPads
after that.

Actually I should probably add it to 64bit too, but still waiting
for at least one report (maybe maybe they have already fixed it in
the Core2 capable models) 

-Andi
