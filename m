Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbTLWVnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 16:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTLWVnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 16:43:37 -0500
Received: from zero.aec.at ([193.170.194.10]:62980 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262767AbTLWVk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 16:40:57 -0500
To: Yaroslav Klyukin <skintwin@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 and x86_64
From: Andi Kleen <ak@muc.de>
Date: Tue, 23 Dec 2003 22:40:48 +0100
In-Reply-To: <162gF-8hY-27@gated-at.bofh.it> (Yaroslav Klyukin's message of
 "Tue, 23 Dec 2003 22:30:25 +0100")
Message-ID: <m3u13rcivz.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <162gF-8hY-27@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yaroslav Klyukin <skintwin@mail.ru> writes:

> Did anybody have any experience with %subj%?
> I am curious about stability.

There are several nasty bugs in 2.6.0/x86-64. Only
use it with the x86-64 patchkit (ftp://ftp.x86-64.org/pub/linux/v2.6/*) 

-Andi
