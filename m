Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264968AbRGEMPM>; Thu, 5 Jul 2001 08:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264973AbRGEMOw>; Thu, 5 Jul 2001 08:14:52 -0400
Received: from gherkin.sa.wlk.com ([192.158.254.49]:1284 "HELO
	gherkin.sa.wlk.com") by vger.kernel.org with SMTP
	id <S264968AbRGEMOs>; Thu, 5 Jul 2001 08:14:48 -0400
Message-Id: <m15I81P-0005khC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
To: alan@lxorguk.ukuu.org.uk
Date: Thu, 5 Jul 2001 07:14:15 -0500 (CDT)
CC: dmircea@kappa.ro, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something I forgot to mention that I didn't see in any of the other
problem reports.  In my case, the panic happens immediately after
"Calibrating delay loop" appears during the boot sequence.

--Bob
