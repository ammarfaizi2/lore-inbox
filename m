Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161416AbWI2Iv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161416AbWI2Iv1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161414AbWI2Iv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:51:27 -0400
Received: from cantor2.suse.de ([195.135.220.15]:18650 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161416AbWI2Iv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:51:26 -0400
From: Andi Kleen <ak@suse.de>
To: Tilman Schmidt <tilman@imap.cc>
Subject: Re: [2.6.18-rc7-mm1] slow boot
Date: Fri, 29 Sep 2006 10:49:07 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, jbeulich@novell.com
References: <4516B966.3010909@imap.cc> <200609281912.01858.ak@suse.de> <451C58AC.5060601@imap.cc>
In-Reply-To: <451C58AC.5060601@imap.cc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609291049.07488.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm afraid I'll need instructions for that. I assume "profile=1"
> is to be appended to the kernel command line; but how do I
> retrieve that readprofile output you are asking for?

With the readprofile command.

But never mind. The problem has been already diagnosed. No fix yet though.

-Andi
