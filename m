Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935746AbWK1JvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935746AbWK1JvZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 04:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935769AbWK1JvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 04:51:25 -0500
Received: from mx1.suse.de ([195.135.220.2]:27563 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S935746AbWK1JvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 04:51:24 -0500
From: Andi Kleen <ak@suse.de>
To: "Zhao Forrest" <forrest.zhao@gmail.com>
Subject: Re: Which patch fix the 8G memory problem on x64 platform?
Date: Tue, 28 Nov 2006 10:45:54 +0100
User-Agent: KMail/1.9.5
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <ac8af0be0611270202i54e376b5jedf91fd7cba35434@mail.gmail.com> <200611271115.55899.ak@suse.de> <ac8af0be0611272133s6a209a53j4c493ec872570a08@mail.gmail.com>
In-Reply-To: <ac8af0be0611272133s6a209a53j4c493ec872570a08@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611281045.54165.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I first need to contact the author of test case if we could send the
> test case to open source. The test case is called "crashme", 

Is that the classical crashme as found in LTP or an enhanced one?
Do you run it in a special way? Is the crash reproducible?

We normally run crashme regularly as part of LTP, Cerberus etc.
so at least any obvious bugs should in theory be caught. 

-Andi
