Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbUCHUc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 15:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbUCHUc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 15:32:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:58782 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261194AbUCHUc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 15:32:58 -0500
Date: Mon, 8 Mar 2004 12:39:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in
 <=16G machines)
In-Reply-To: <20040308202433.GA12612@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0403081238060.9575@ppc970.osdl.org>
References: <20040308202433.GA12612@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,
 I certainly prefer this to the 4:4 horrors. So it sounds worth it to put
it into -mm if everybody else is ok with it.

		Linus
