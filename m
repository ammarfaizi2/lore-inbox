Return-Path: <linux-kernel-owner+w=401wt.eu-S1754021AbWLRNs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbWLRNs3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 08:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754020AbWLRNs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 08:48:28 -0500
Received: from khc.piap.pl ([195.187.100.11]:37122 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754018AbWLRNs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 08:48:27 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the broken SCSI_SEAGATE driver
References: <20061212162238.GR28443@stusta.de>
	<1165966274.5903.56.camel@mulgrave.il.steeleye.com>
	<20061213000902.GD28443@stusta.de>
	<m3wt4tp9ka.fsf@defiant.localdomain>
	<1166198454.2846.10.camel@mulgrave.il.steeleye.com>
	<m3ac1mb88s.fsf@defiant.localdomain>
	<1166386966.9647.20.camel@mulgrave.il.steeleye.com>
	<m3tzzu9q7k.fsf@defiant.localdomain>
	<1166431702.3365.934.camel@laptopd505.fenrus.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 18 Dec 2006 14:48:25 +0100
In-Reply-To: <1166431702.3365.934.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "Mon, 18 Dec 2006 09:47:02 +0100")
Message-ID: <m3ac1l2u3a.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> if a tree falls in a forest but there's nobody around to hear it, does
> it make a sound?
>
> This sort of heisenbug questions aren't solved by "nobody hears it so
> lets chop down the forest to make houses out of the wood" answers...

Does that mean you don't want to know which hardware/drivers aren't used
anymore and which ones are?
-- 
Krzysztof Halasa
