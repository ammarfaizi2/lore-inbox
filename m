Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbVDYPwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVDYPwv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 11:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVDYPvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:51:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2739 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262627AbVDYPjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:39:21 -0400
Date: Mon, 25 Apr 2005 17:09:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050425150927.GA2508@elf.ucw.cz>
References: <4263275A.2020405@lab.ntt.co.jp> <m1y8b9xyaw.fsf@muc.de> <426C51C4.9040902@lab.ntt.co.jp> <e83d0cb60cb50a56b38294e9160d7712@mac.com> <426CC8F7.8070905@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426CC8F7.8070905@lab.ntt.co.jp>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Kyle, thank you so much for your detailed information.
> If you design completely new software, your suggestion is very useful!
> 
> Unfortunately, we carrier have very many exiting software and try to run
> on Linux.
> We need to seek the way which can apply to exiting software also...

"We want to do the wrong thing because we think its easier".

Okay, you are free to do that, but don't try to push that into
mainline kernel. Maintain your own patches; if that seems too hard, do
the right thing.
									Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
