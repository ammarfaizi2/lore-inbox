Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTD1XrN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 19:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTD1XrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 19:47:13 -0400
Received: from zero.aec.at ([193.170.194.10]:31247 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261176AbTD1XrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 19:47:12 -0400
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make struct alt_instr acceptable to userland
From: Andi Kleen <ak@muc.de>
Date: Tue, 29 Apr 2003 01:59:20 +0200
In-Reply-To: <20030428225019$00fe@gated-at.bofh.it> (Bryan O'Sullivan's
 message of "Tue, 29 Apr 2003 00:50:19 +0200")
Message-ID: <m3llxudvhj.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <20030428225019$00fe@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan <bos@serpentine.com> writes:

> Andi's new struct alt_instr is visible to klibc.  The attached patch
> changes the types it uses, so that klibc becomes happy.

Thanks. I changed it in my sources.

I already have some updates/cleanups for the mechanism queued, will
submit it with that.

-Andi
