Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbTL2VwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 16:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTL2VwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 16:52:25 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:36238 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264275AbTL2VwY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 16:52:24 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 29 Dec 2003 13:52:24 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: ramon.rey@hispalinux.es, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: 2.6.0-mm2
In-Reply-To: <1072731446.5170.4.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.44.0312291351150.2380-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003, Felipe Alfaro Solana wrote:

> The same happens here. cdrecord is broken under -mm, but works fine with
> plain 2.6.0.

cdrecord works fine here (-mm1) using hdX=ide-cd and dev=ATAPI:...



- Davide


