Return-Path: <linux-kernel-owner+w=401wt.eu-S1751764AbWLMXrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWLMXrX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbWLMXrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:47:23 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48762 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751764AbWLMXrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:47:22 -0500
Date: Wed, 13 Dec 2006 23:55:00 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Michael K. Edwards" <medwards.linux@gmail.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Martin Bligh" <mbligh@mbligh.org>,
       "Greg KH" <gregkh@suse.de>, "Linus Torvalds" <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Message-ID: <20061213235500.1764d85e@localhost.localdomain>
In-Reply-To: <f2b55d220612131420l5f956e05qb10ef233670fb588@mail.gmail.com>
References: <20061213195226.GA6736@kroah.com>
	<Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
	<f2b55d220612131238h6829f51ao96c17abbd1d0b71d@mail.gmail.com>
	<20061213210219.GA9410@suse.de>
	<45807182.1060408@mbligh.org>
	<20061213134721.d8ff8c11.akpm@osdl.org>
	<f2b55d220612131420l5f956e05qb10ef233670fb588@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IIRC, Linus has deliberately and explicitly estopped himself from
> claiming that loading a binary-only driver is a GPL violation.  Do you

He only owns a small amount of the code. Furthermore he imported third
party GPL code using the license as sole permission. So he may have dug a
personal hole but many of the rest of us have been repeatedly saying
whenever he said that - that we do not agree. The FSF has always said
binary modules are wrong and there is FSF code imported into the kernel
by Linus on license only grounds.

Whether it is a good idea is a different question.

Alan.
