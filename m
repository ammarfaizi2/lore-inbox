Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263860AbUEHAMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263860AbUEHAMM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 20:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbUEHAMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 20:12:12 -0400
Received: from mail0-105.ewetel.de ([212.6.122.105]:23440 "EHLO
	mail0.ewetel.de") by vger.kernel.org with ESMTP id S263860AbUEHALy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 20:11:54 -0400
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange Linux behaviour!?
In-Reply-To: <1ThkH-63V-1@gated-at.bofh.it>
References: <1T8Ks-7ED-15@gated-at.bofh.it> <1T93S-7SM-11@gated-at.bofh.it> <1T9dz-80x-17@gated-at.bofh.it> <1ThkH-63V-1@gated-at.bofh.it>
Date: Fri, 7 May 2004 21:44:29 +0200
Message-Id: <E1BMBGn-0000Gj-8k@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 May 2004 19:30:08 +0200, you wrote in linux.kernel:

> What happens when Linux runs out of inodes?  Why would it?  Doesn't it 
> create more?

For many filesystems, the number of inodes *on* *disk* is set at
mkfs time.

-- 
Ciao,
Pascal
