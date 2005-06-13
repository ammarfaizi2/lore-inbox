Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVFMUFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVFMUFA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVFMUDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:03:34 -0400
Received: from opersys.com ([64.40.108.71]:55564 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261234AbVFMT72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:59:28 -0400
Subject: Re: network driver disabled interrupts in PREEMPT_RT
From: Kristian Benoit <kbenoit@opersys.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050613185642.GA12463@elte.hu>
References: <1118688347.5792.12.camel@localhost>
	 <20050613185642.GA12463@elte.hu>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 15:56:37 -0400
Message-Id: <1118692597.5792.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 20:56 +0200, Ingo Molnar wrote:
> does the patch below fix it?

It does!
thank you, the data I'm collecting make much more sens now !!

Kristian

