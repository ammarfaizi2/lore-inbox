Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbVLKNqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVLKNqU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 08:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbVLKNqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 08:46:20 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46257 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751362AbVLKNqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 08:46:19 -0500
Date: Sun, 11 Dec 2005 14:45:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: david singleton <dsingleton@mvista.com>
Cc: robustmutexes@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Robust futex update:
Message-ID: <20051211134528.GA30475@elte.hu>
References: <3EC7CB34-6913-11DA-BDBB-000A959BB91E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC7CB34-6913-11DA-BDBB-000A959BB91E@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.6 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* david singleton <dsingleton@mvista.com> wrote:

> 	There is a new robust futex patch on 
> http://source.mvista.com/~dsingleton/patch-2.6.14-rt22-rf11
> 	that fixes three bugs.  One of the bugs was an SMP race 
> 	condition that Dave Carlson had spotted and has been gracious 
> 	enough to test for me.

thanks, applied.

	Ingo
