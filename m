Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbTL2W06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 17:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbTL2W06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 17:26:58 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:57861 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265117AbTL2W05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 17:26:57 -0500
Subject: Re: 2.6.0-mm2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: ramon.rey@hispalinux.es, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.44.0312291351150.2380-100000@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.44.0312291351150.2380-100000@bigblue.dev.mdolabs.com>
Content-Type: text/plain
Message-Id: <1072736815.5170.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 29 Dec 2003 23:26:56 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-29 at 22:52, Davide Libenzi wrote:
> On Mon, 29 Dec 2003, Felipe Alfaro Solana wrote:
> 
> > The same happens here. cdrecord is broken under -mm, but works fine with
> > plain 2.6.0.
> 
> cdrecord works fine here (-mm1) using hdX=ide-cd and dev=ATAPI:...

Yep, but cdrecord fails when using "cdrecord -dev=/dev/hdx" under -mm
but works perfectly under vanilla 2.6.0.

