Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271755AbTGXWmv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 18:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271758AbTGXWmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 18:42:51 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:28067 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S271755AbTGXWmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 18:42:50 -0400
Date: Fri, 25 Jul 2003 00:57:45 +0200
From: Pavel Machek <pavel@suse.cz>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: schierlm@gmx.de, linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: touchpad doesn't work under 2.6.0-test1-ac2
Message-ID: <20030724225745.GA434@elf.ucw.cz>
References: <bXg8.4Wg.1@gated-at.bofh.it> <S270097AbTGXUNM/20030724201313Z+7864@vger.kernel.org> <20030724212416.GA18141@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030724212416.GA18141@vana.vc.cvut.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This all happens on Compaq EVO N800C. I strongly believe that we need a
> build time option for disabling Synaptics detection, or at least input_synaptics=0
> runtime option, until it can work at least as well as it works like ps/2
> device.

Agreed, I even send a patch to vojtech, he said he is going to apply
it and I have not heard about that patch after that...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
