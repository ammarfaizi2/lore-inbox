Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWIZLp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWIZLp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 07:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWIZLp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 07:45:27 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:54896 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751083AbWIZLp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 07:45:26 -0400
Message-Id: <20060926113150.294656000@chello.nl>
User-Agent: quilt/0.45-1
Date: Tue, 26 Sep 2006 13:31:50 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jikos@jikos.cz>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 0/2] serio lockdep annotation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

These patches should quiet lockdep down for serio.
Ideas were reaped from the previous thread on this subject.
  http://lkml.org/lkml/2006/9/13/256

I hope this version does satisfy all parties.

Unfortunately I do not appear to have offending hardware, so if anybody
could confirm that they indeed do as advertised...

Peter
--

