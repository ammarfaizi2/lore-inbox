Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754263AbWKGSzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbWKGSzV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754267AbWKGSzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:55:21 -0500
Received: from mail.parknet.jp ([210.171.160.80]:22283 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1754263AbWKGSzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:55:20 -0500
X-AuthUser: hirofumi@parknet.jp
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
References: <4550A481.2010408@scientia.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 08 Nov 2006 03:55:09 +0900
In-Reply-To: <4550A481.2010408@scientia.net> (Christoph Anton Mitterer's message of "Tue\, 07 Nov 2006 16\:21\:37 +0100")
Message-ID: <87psbzrss2.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Anton Mitterer <calestyo@scientia.net> writes:

> The strange thing is that one time the differences were found directly
> after copying (thus one would thing RAM is damaged, because the data was
> probalby (I cannot tell this for sure) taken from file cache).
> and the other time after restarting with a certainly empty file cache.
>
> Any ideas? I'm willing to help debugging and so on but I must admit that
> I need someone to say me what to do :D

bit interesting. Could you send the output of diff? I'd like to see
how it's breaking.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
