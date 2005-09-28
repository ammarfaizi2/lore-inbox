Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbVI1Jct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVI1Jct (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 05:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVI1Jct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 05:32:49 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:46270 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751194AbVI1Jcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 05:32:48 -0400
Date: Wed, 28 Sep 2005 11:33:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RT: epca_lock to DEFINE_SPINLOCK
Message-ID: <20050928093336.GB30820@elte.hu>
References: <1127845928.4004.24.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127845928.4004.24.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> Convert epca_lock to the new syntax.

thanks, applied.

	Ingo
