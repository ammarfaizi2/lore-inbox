Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268364AbTGIPaq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 11:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268372AbTGIPaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 11:30:46 -0400
Received: from ns.suse.de ([213.95.15.193]:38669 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268364AbTGIPap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 11:30:45 -0400
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: modutils-2.3.15 'insmod'
References: <Pine.LNX.4.53.0307091119450.470@chaos>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I want to read my new poem about pork brains and outer space...
Date: Wed, 09 Jul 2003 17:45:22 +0200
In-Reply-To: <Pine.LNX.4.53.0307091119450.470@chaos> (Richard B. Johnson's
 message of "Wed, 9 Jul 2003 11:25:11 -0400 (EDT)")
Message-ID: <jer84zln59.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

|> It is likely that malloc(0) returning a valid pointer is a bug
|> that has prevented this problem from being observed.

It's not a bug, it's a behaviour explicitly allowed by the C standard.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
