Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWBWMsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWBWMsk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 07:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWBWMsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 07:48:40 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:26765 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751151AbWBWMsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 07:48:40 -0500
Date: Thu, 23 Feb 2006 13:47:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RT : 2.6.15-rt17 and possible softlockup detected on CPU#1!
Message-ID: <20060223124715.GA11291@elte.hu>
References: <200602231354.32259.Serge.Noiraud@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602231354.32259.Serge.Noiraud@bull.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.3 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> These messages occurs while my RT program loops.

what priority does your RT program have?

	Ingo
