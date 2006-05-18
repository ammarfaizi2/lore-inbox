Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWERIGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWERIGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 04:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWERIGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 04:06:20 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:15845 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751082AbWERIGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 04:06:18 -0400
Date: Thu, 18 May 2006 10:06:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt 1/2] arm: add irqflags.h
Message-ID: <20060518080616.GD30387@elte.hu>
References: <200605141556.k4EFu1iR004703@dwalker1.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605141556.k4EFu1iR004703@dwalker1.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> This adds the asm-arm/irqflags.h needed by RT .

thanks, applied. (minor issue: there was an extra space at the end of 
one of the lines - a 'quilt refresh' shows this automatically.)

	Ingo
