Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbVIKSss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVIKSss (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 14:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbVIKSss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 14:48:48 -0400
Received: from mail4.ewetel.de ([212.6.122.28]:1714 "EHLO mail4.ewetel.de")
	by vger.kernel.org with ESMTP id S965028AbVIKSsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 14:48:47 -0400
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: Re: sungem driver patch testing..
In-Reply-To: <Pine.LNX.4.58.0509110940220.4912@g5.osdl.org>
References: <Pine.LNX.4.58.0509102008540.4912@g5.osdl.org> <20050911120332.GA7627@infradead.org>
Date: Sun, 11 Sep 2005 20:48:32 +0200
Message-Id: <E1EEWsS-0000HC-TT@localhost>
From: Pascal Schmidt <pascal.schmidt@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sep 2005 19:10:06 +0200, you wrote:

> Here's a patch (on top of the previous PCI ROM mapping fix) that does
> that. It seems to work for me, but I can't really test it, and it's mostly
> just cleanup, so I'm not going to apply it.

I can confirm that it doesn't break the Sun GEM in my iBook G4,
but then that probably also doesn't trigger the changed code.

-- 
Ciao,
Pascal
