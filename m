Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbUCCO31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 09:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbUCCO31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 09:29:27 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:63141 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262460AbUCCO30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 09:29:26 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 3 Mar 2004 06:29:48 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Roland Dreier <roland@topspin.com>, <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
In-Reply-To: <Pine.LNX.4.53.0403030736350.11111@chaos>
Message-ID: <Pine.LNX.4.44.0403030627440.26030-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2004, Richard B. Johnson wrote:

> Clearly this task is sleeping in do_poll.

I don't believe anyone ever argued that do_poll() sleeps. You were saying 
that poll_wait() was sleeping, that is different.


- Davide



