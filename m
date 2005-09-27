Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbVI0Kcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbVI0Kcy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 06:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbVI0Kcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 06:32:54 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36562 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964893AbVI0Kcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 06:32:54 -0400
Date: Tue, 27 Sep 2005 12:33:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Eran Mann <emann@mrv.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-rt2
Message-ID: <20050927103340.GA2727@elte.hu>
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu> <4338E301.4090808@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4338E301.4090808@mrv.com>
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


* Eran Mann <emann@mrv.com> wrote:

> The attached 2 patches (against 2.6.14-rc2-rt3) seem to be required to 
> compile dccp and nfnetlink (only compile-tested).

thanks, applied.

	Ingo
