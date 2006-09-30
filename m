Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWI3WDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWI3WDv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWI3WDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:03:51 -0400
Received: from mx1.suse.de ([195.135.220.2]:28573 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751403AbWI3WDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:03:50 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric Rannaud" <eric.rannaud@gmail.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Date: Sun, 1 Oct 2006 00:03:43 +0200
User-Agent: KMail/1.9.3
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Ingo Molnar" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>,
       nagar@watson.ibm.com, "Chandra Seetharaman" <sekharan@us.ibm.com>,
       "Jan Beulich" <jbeulich@novell.com>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com> <200609302230.24070.ak@suse.de> <5f3c152b0609301443l5061af04w5740babdfa3dbd3b@mail.gmail.com>
In-Reply-To: <5f3c152b0609301443l5061af04w5740babdfa3dbd3b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610010003.43306.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For the sake of it, I tried your patch (more exactly the version at
> the end of that email, againt v2.6.18). It doesn't freeze and prints
> the following stack trace:

Thanks for testing.

-Andi
