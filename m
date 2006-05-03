Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWECUlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWECUlQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 16:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWECUlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 16:41:16 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:25028 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750877AbWECUlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 16:41:15 -0400
Date: Wed, 3 May 2006 22:46:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt] remove redundent checks
Message-ID: <20060503204609.GB15965@elte.hu>
References: <200604221505.k3MF54Lr021983@dwalker1.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604221505.k3MF54Lr021983@dwalker1.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> 	Don't need to check twice .. I also removed an old printk from 
> schedule() .

thanks, applied.

	Ingo
