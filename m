Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbUACFtJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 00:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbUACFtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 00:49:09 -0500
Received: from pD9E56DF6.dip.t-dialin.net ([217.229.109.246]:63386 "EHLO
	fred.muc.de") by vger.kernel.org with ESMTP id S262674AbUACFtI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 00:49:08 -0500
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export idle_warning (x86-64)
From: Andi Kleen <ak@muc.de>
Date: Sat, 03 Jan 2004 06:49:04 +0100
In-Reply-To: <19Md2-1Yh-7@gated-at.bofh.it> (Srihari Vijayaraghavan's
 message of "Sat, 03 Jan 2004 06:10:08 +0100")
Message-ID: <m3brplvay7.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <19Md2-1Yh-7@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srihari Vijayaraghavan <harisri@bigpond.com> writes:

> Without this patch the ACPI processor module does not load (and hence thermal 
> module too):

Thanks. I applied the patch.

-Andi
