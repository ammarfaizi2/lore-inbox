Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269514AbTHFPbU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 11:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269542AbTHFPbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 11:31:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:35724 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269514AbTHFPbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 11:31:19 -0400
Date: Wed, 6 Aug 2003 08:31:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Andi Kleen <ak@colin2.muc.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Export touch_nmi_watchdog
In-Reply-To: <20030806130656.R639@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.44.0308060830010.4916-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 6 Aug 2003, Ingo Oeser wrote:
>
> So if you don't have the time to fix it, it's simply a problem
> with your management ignoring its customers ;-/

Well, probably no. The _customers_ are probably perfectly happy with just 
papering the thing over. I'm not worried about that side. So I'd be more 
worried about the developers in the long run.

		Linus

