Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVJNP2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVJNP2l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 11:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVJNP2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 11:28:41 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:38056 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1750760AbVJNP2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 11:28:41 -0400
Message-Id: <E1EQRa1-0001CH-0r@localhost.localdomain>
From: lk@sound-man.co.uk
Date: Fri, 14 Oct 2005 16:34:45 +0100
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: 2.6.14-rc4-rt1
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
From: John Rigg <lk@sound-man.co.uk>

Ingo, I just tried the patch you posted in reply to Badari Pulavarty's
boot crash message. I get an error when trying to patch 2.6.14-rc4-rt4:

patching file arch/x86_64/kernel/vsyscall.c
patch: **** malformed patch at line 11: notrace

John
