Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVDJKxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVDJKxx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 06:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVDJKxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 06:53:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:59835 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261468AbVDJKxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 06:53:52 -0400
Date: Sun, 10 Apr 2005 12:53:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, sdietrich@mvista.com,
       inaky.perez-gonzalez@intel.com
Subject: Re: [PATCH] Priority Lists for the RT mutex
Message-ID: <20050410105319.GA7303@elte.hu>
References: <1112896344.16901.26.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112896344.16901.26.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> Description:
> 	This patch adds the priority list data structure from Inaky 
> Perez-Gonzalez to the Preempt Real-Time mutex.

ok, i've added this patch to the -45-00 release. It's looking good on my 
testsystems so far, but it will need some more testing i guess.

	Ingo
