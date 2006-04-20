Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWDTPVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWDTPVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 11:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWDTPVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 11:21:14 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:62340 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750999AbWDTPVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 11:21:13 -0400
Date: Thu, 20 Apr 2006 17:26:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gerd Hoffmann <kraxel@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: smp/up alternatives crash when CONFIG_HOTPLUG_CPU
Message-ID: <20060420152609.GA21993@elte.hu>
References: <20060419094630.GA14800@elte.hu> <20060420052954.GA5524@elte.hu> <Pine.LNX.4.64.0604200759400.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604200759400.3701@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> There must be another bug there somewhere. It's not about cache 
> coherency.

ok. Maybe it's in one of the patches i have applied. I'll re-check with 
vanilla.

	Ingo
