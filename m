Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVKOH4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVKOH4E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 02:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbVKOH4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 02:56:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57820 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932322AbVKOH4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 02:56:02 -0500
Date: Tue, 15 Nov 2005 08:56:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH -rt] Make rcutorture be a module
Message-ID: <20051115075602.GA6251@elte.hu>
References: <20051113204542.GA8739@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051113204542.GA8739@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> Hello!
> 
> Make rcutorture be a module, as it currently is in mainline.  Also add 
> a definite success/failure indication and a test for 
> architecture-specific memory barriers (in their interaction with RCU).
> 
> Signed-off-by: <paulmck@us.ibm.com>

thanks, applied.

	Ingo
