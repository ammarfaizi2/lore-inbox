Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVBOJcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVBOJcv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 04:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVBOJcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 04:32:51 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:57939
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261660AbVBOJcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 04:32:46 -0500
Date: Tue, 15 Feb 2005 10:32:44 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: seccomp for 2.6.11-rc4
Message-ID: <20050215093244.GU13712@opteron.random>
References: <20050121100606.GB8042@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121100606.GB8042@dualathlon.random>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is the latest version against 2.6.11-rc4:

	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.11-rc4/seccomp

I'd need it merged into mainline at some point, unless anybody has
strong arguments against it. All I can guarantee here, is that I'll back
it out myself in the future, iff Cpushare will fail and nobody else
started using it in the meantime for similar security purposes.

Thanks.
