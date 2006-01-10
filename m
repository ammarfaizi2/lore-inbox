Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932695AbWAJVNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbWAJVNE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWAJVNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:13:04 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:9900 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932695AbWAJVNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:13:02 -0500
Date: Tue, 10 Jan 2006 22:13:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Split schedule() {raw_}irq warnings
Message-ID: <20060110211315.GB9683@elte.hu>
References: <200601101823.k0AINfMt032199@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601101823.k0AINfMt032199@dhcp153.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> 	I changed this error message so it's clear what triggered it.
> If it's a raw_ type it says it's raw.
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>

ok, added it. (with small modifications)

	Ingo
