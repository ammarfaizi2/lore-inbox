Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVGENBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVGENBh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 09:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVGENBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 09:01:33 -0400
Received: from odin2.bull.net ([192.90.70.84]:35029 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261813AbVGEMxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 08:53:55 -0400
Subject: RT 50-51 : cannot compile on i386
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: BTS
Message-Id: <1120567250.6225.24.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Tue, 05 Jul 2005 14:40:50 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have another compile problem :

  CC      arch/i386/kernel/apm.o
arch/i386/kernel/apm.c:424: error: syntax error before ',' token
arch/i386/kernel/apm.c:425: error: syntax error before ',' token
arch/i386/kernel/apm.c:427: error: syntax error before ',' token


