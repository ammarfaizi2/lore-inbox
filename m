Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265619AbUBPPbL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265643AbUBPPbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:31:11 -0500
Received: from mail1-106.ewetel.de ([212.6.122.106]:19161 "EHLO
	mail1.ewetel.de") by vger.kernel.org with ESMTP id S265619AbUBPPbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:31:09 -0500
To: Eduard Bloch <edi@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior
In-Reply-To: <1pRVj-2am-29@gated-at.bofh.it>
References: <1pvUz-6j-1@gated-at.bofh.it> <1pRVj-2am-29@gated-at.bofh.it>
Date: Mon, 16 Feb 2004 16:32:26 +0100
Message-Id: <E1AskjS-0000OQ-3K@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004 15:30:21 +0100, you wrote in linux.kernel:

> When I do this, I still cannot enter unicode chars "as usual". I see
> them, mutt (for example) displays everything correct with a UTF-8
> locale. However, I cannot insert them correctly. When I use vim, I have
> to press another key (eg. Space) 2..4 times after an umlaut was pressed,
> only then the char appears.

You're right, inputing UTF-8 (in joe) doesn't work, but that's an
application problem, I think, because it works just fine on a shell
prompt.

-- 
Ciao,
Pascal
