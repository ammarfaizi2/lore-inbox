Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266054AbTG1Kex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 06:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbTG1Kew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 06:34:52 -0400
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:5640 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP id S265772AbTG1Ket
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 06:34:49 -0400
Message-ID: <200307281249530272.12DD7F41@192.168.128.16>
In-Reply-To: <Pine.LNX.4.44.0307272133140.24695-100000@dlang.diginsite.com>
References: <Pine.LNX.4.44.0307272133140.24695-100000@dlang.diginsite.com>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Mon, 28 Jul 2003 12:49:53 +0200
From: "Carlos Velasco" <carlosev@newipnet.com>
To: "David Lang" <david.lang@digitalinsight.com>,
       "David S. Miller" <davem@redhat.com>
Cc: bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2003 at 21:37 David Lang wrote:

>P.S. there are standards that are written documents and there are
>standards that are 'how everyone does it' for the most part Linux
follows
>both types of standards, in this case the network team has decided to
>ignore the 'how everyone else does it' standards becouse there is
nothing
>in a written standard that they are violating

No problem behaving different. The questions are...
What is the advantage of doing it in this case?
Why not implementing an easy way to do linux behave like the other OS
and systems?

Regards,
Carlos Velasco


