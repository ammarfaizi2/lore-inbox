Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbVH2LJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVH2LJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 07:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVH2LJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 07:09:29 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:48026 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751035AbVH2LJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 07:09:28 -0400
Subject: Re: 2.6.13-rt1
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com
In-Reply-To: <20050829084829.GA23176@elte.hu>
References: <20050829084829.GA23176@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 29 Aug 2005 07:09:04 -0400
Message-Id: <1125313744.5611.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I think you have a slight glitch in your patch.

-- Steve

$ patch -p1 -s < /work/realtime-patches/patch-2.6.13-rt1
The next patch would delete the file Makefile.rej,
which does not exist!  Assume -R? [n]
Apply anyway? [n]




