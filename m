Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbTFCWQY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 18:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTFCWQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 18:16:24 -0400
Received: from taba2.icmc.usp.br ([143.107.231.16]:18601 "EHLO
	mail.icmc.usp.br") by vger.kernel.org with ESMTP id S261564AbTFCWQX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 18:16:23 -0400
Date: Tue, 3 Jun 2003 19:26:42 -0300 (EST)
From: William Voorsluys <william@icmc.usp.br>
To: linux-kernel@vger.kernel.org
Subject: NPTL/SMP/NUMA
Message-ID: <Pine.GSO.4.05.10306031914120.1819-100000@ceci>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been reading about the advantages of the NPTL threads library but I
couldn't find the answers for some questions. The main doubt is related to
its advantages on SMP machines.
Many things have been made on the kernel to make the threads library
better, like the introduction of futexes, changes on the signal handling
mechanism, use of new architecture specific data structures, and so on. A
lot is said about the benefits of using the new threads implementations on
SMP machines. I'd like to know which changes have been made specifically
thinking on SMP machines, and which have been made to other purposes?
Is there any feature on the library/kernel that make it possible to
exploit the benefits of NUMA systems?

Thanks

William 

