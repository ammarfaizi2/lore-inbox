Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbWIKVTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWIKVTB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWIKVTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:19:01 -0400
Received: from mx1.suse.de ([195.135.220.2]:21386 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965052AbWIKVSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:18:48 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] i386-PDA, lockdep: fix %gs restore
Date: Mon, 11 Sep 2006 22:20:00 +0200
User-Agent: KMail/1.9.1
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
References: <20060908011317.6cb0495a.akpm@osdl.org> <450499D3.5010903@goop.org> <20060911052527.GA12301@elte.hu>
In-Reply-To: <20060911052527.GA12301@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609112220.01032.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 September 2006 07:25, Ingo Molnar wrote:
> Jeremy,
>
> could you back out Andi's patch and try the patch below, does it fix the
> crash too?

I folded it into the original patch now thanks

-Andi
