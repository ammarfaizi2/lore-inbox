Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVCLBip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVCLBip (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 20:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVCLBiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 20:38:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:21126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261895AbVCLBfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 20:35:23 -0500
Date: Fri, 11 Mar 2005 17:35:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Felix von Leitner <felix-linuxkernel@fefe.de>
Cc: linux-kernel@vger.kernel.org, cpufreq@ZenII.linux.org.uk
Subject: Re: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino
 speedstep even more broken than in 2.6.10
Message-Id: <20050311173517.7fe95918.akpm@osdl.org>
In-Reply-To: <20050311202122.GA13205@fefe.de>
References: <20050311202122.GA13205@fefe.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner <felix-linuxkernel@fefe.de> wrote:
>
> Finally Centrino SpeedStep.
> I have a "Intel(R) Pentium(R) M processor 1.80GHz" in my notebook.
> Linux does not support it.  This architecture has been out there for
> months now, and there even was a patch to support it posted here a in
> October last year or so.  Linux still does not include it.  Until
> 2.6.11-rc4-bk8 or so, the old patched file from back then still worked.
> Now it doesn't.  Because some interface changed.  Now what?  Using a
> Centrino notebook without CPU throttling is completely out of the
> question.  Linux might as well not boot on it at all.

Could you please dig out the old patch, send it?

