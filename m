Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265627AbUBPPWq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265639AbUBPPWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:22:46 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:27018 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265627AbUBPPV6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:21:58 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 16 Feb 2004 07:21:57 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: RANDAZZO@ddc-web.com
cc: linux-kernel@vger.kernel.org
Subject: Re: what to use (sem/spinlock/etc)....
In-Reply-To: <89760D3F308BD41183B000508BAFAC4104B16F79@DDCNYNTD>
Message-ID: <Pine.LNX.4.44.0402160721000.1639-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004 RANDAZZO@ddc-web.com wrote:

> ...any opinion of what I should use....

I'd say a spindoc:

http://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/



- Davide


