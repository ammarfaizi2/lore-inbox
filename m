Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276275AbRJCNgI>; Wed, 3 Oct 2001 09:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276270AbRJCNft>; Wed, 3 Oct 2001 09:35:49 -0400
Received: from robur.slu.se ([130.238.98.12]:16135 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S276266AbRJCNfn>;
	Wed, 3 Oct 2001 09:35:43 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15291.5314.595897.458571@robur.slu.se>
Date: Wed, 3 Oct 2001 15:38:10 +0200
To: jamal <hadi@cyberus.ca>
Cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110030850480.4495-100000@shell.cyberus.ca>
In-Reply-To: <Pine.LNX.4.33.0110031108550.2679-100000@localhost.localdomain>
	<Pine.GSO.4.30.0110030850480.4495-100000@shell.cyberus.ca>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



jamal writes:

 > The paper is at: http://www.cyberus.ca/~hadi/usenix-paper.tgz
 > Robert can point you to the latest patches.


 Current code... there are still some parts we like to better.

 Available via ftp from robur.slu.se:/pub/Linux/net-development/NAPI/
 2.4.10-poll.pat
 
 The original code:

 ANK-NAPI-tulip-only.pat
 ANK-NAPI-kernel-only.pat

 And for GIGE there is a e1000 driver in test. 

 Cheers.

						--ro


 
