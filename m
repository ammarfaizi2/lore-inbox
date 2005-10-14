Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVJNSHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVJNSHU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVJNSHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:07:19 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:61612 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1750818AbVJNSHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:07:18 -0400
Subject: Re: 2.6.14-rc4-rt4
To: linux-kernel@vger.kernel.org
From: John Rigg <lk@sound-man.co.uk>
Message-Id: <E1EQU3c-0001Jr-P5@localhost.localdomain>
Date: Fri, 14 Oct 2005 19:13:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 October 2005 John Rigg wrote:
>Ingo, I just tried the patch you posted in reply to Badari Pulavarty's
>boot crash message. I get an error when trying to patch 2.6.14-rc4-rt4:
>
>patching file arch/x86_64/kernel/vsyscall.c
>patch: **** malformed patch at line 11: notrace

Excuse my stupidity - lynx wrapped the line when I printed it to a file.
Of course it patches cleanly with the \n removed.

John
