Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWGKNeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWGKNeP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWGKNeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:34:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1686 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750766AbWGKNeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:34:14 -0400
Subject: RE: [discuss] Re: [PATCH] Allow all Opteron processors to change
	pstate at same time
From: Arjan van de Ven <arjan@infradead.org>
To: "Langsdorf, Mark" <mark.langsdorf@amd.com>
Cc: Andi Kleen <ak@suse.de>, "Deguara, Joachim" <joachim.deguara@amd.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       cpufreq@lists.linux.org.uk
In-Reply-To: <84EA05E2CA77634C82730353CBE3A84303218EA4@SAUSEXMB1.amd.com>
References: <84EA05E2CA77634C82730353CBE3A84303218EA4@SAUSEXMB1.amd.com>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 15:34:10 +0200
Message-Id: <1152624850.3128.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Customers in the field seem to want to use TSC for gtod,
> so I want to know how awful an idea that is.

in userspace or in the kernel? And do you happen to know why they don't
want to use hpet?

Greetings,
    Arjan van de Ven

