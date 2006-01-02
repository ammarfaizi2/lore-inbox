Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWABMoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWABMoy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 07:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWABMoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 07:44:54 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:22236 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750704AbWABMox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 07:44:53 -0500
Date: Mon, 2 Jan 2006 13:44:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "linux-kernel @ vger. kernel. org" <linux-kernel@vger.kernel.org>
Subject: Re: BUG in 2.6.15-rc7-rt1
Message-ID: <20060102124449.GA27243@elte.hu>
References: <20060102132700.54637110@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102132700.54637110@mango.fruits.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> P.S.: .config:

could you please send full .config's, that i could just stick in and 
try? I have no good way to regenerate the original .config from such 
configs.

	Ingo
