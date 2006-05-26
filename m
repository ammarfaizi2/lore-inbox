Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWEZTnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWEZTnE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 15:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWEZTnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 15:43:04 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:29152 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750781AbWEZTnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 15:43:01 -0400
Date: Fri, 26 May 2006 21:43:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.16-rt24 Won't Apply
Message-ID: <20060526194315.GA860@elte.hu>
References: <44775129.6030004@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44775129.6030004@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> Ingo,
> 
> The 2.6.16-rt24 patch that you uploaded today will not apply cleanly 
> to a 2.6.16 source tree. Below is the first of many problems, if this 
> helps.

could you try -rt25, does it work any better?

	Ingo
