Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbTI2R6l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264059AbTI2Ryg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:54:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:52642 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264028AbTI2Rxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:53:53 -0400
Date: Mon, 29 Sep 2003 10:53:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: davej@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Cleanup SEP errata workaround.
In-Reply-To: <E1A41Rq-0000N1-00@hardwired>
Message-ID: <Pine.LNX.4.44.0309291052560.1448-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Sep 2003 davej@redhat.com wrote:
>
> This looks a little simpler, and has the same effect.

Well, "almost same". Let's hope that Intel never releases an old Pentium
with SEP ;)

Applied.

		Linus

