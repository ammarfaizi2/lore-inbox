Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTLOO6f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 09:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTLOO6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 09:58:35 -0500
Received: from zero.aec.at ([193.170.194.10]:37640 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263763AbTLOO6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 09:58:34 -0500
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI Express support for 2.4 kernel
From: Andi Kleen <ak@muc.de>
Date: Mon, 15 Dec 2003 15:58:17 +0100
In-Reply-To: <12Z5u-1tG-11@gated-at.bofh.it> (Vladimir Kondratiev's message
 of "Mon, 15 Dec 2003 12:30:17 +0100")
Message-ID: <m3iskip1py.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <12KJ6-4F2-13@gated-at.bofh.it> <12XQc-7Vs-29@gated-at.bofh.it>
	<12Z5u-1tG-11@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Kondratiev <vladimir.kondratiev@intel.com> writes:
>>
> I thought this way also. But I found that it is not. You may know
> several chipsets,
> and do per-chipset stuff, but there is no generic procedure. At least
> authors of PCI-E
> don't know (it is nice to have access to the authors ;-) ).

This sounds like a serious design flaw in PCI-Express. Can you 
ask them to address this before it is too late? 

-Andi
