Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422672AbWAMNwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbWAMNwc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 08:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422674AbWAMNwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 08:52:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:60840 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1422672AbWAMNwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 08:52:31 -0500
Date: Fri, 13 Jan 2006 14:52:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixed a compile bug in 2.6.15-rt4
Message-ID: <20060113135247.GA24021@elte.hu>
References: <ff1cadb20601130141k1ef91fcdr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff1cadb20601130141k1ef91fcdr@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Luca Falavigna <dktrkranz@gmail.com> wrote:

> This patch fixes a compile bug in 2.6.15-rt4, but I think it is 
> present in hrtimer implementation too.
> 
> Signed-off-by: Luca Falavigna <dktrkranz@gmail.com

thanks, applied.

	Ingo
