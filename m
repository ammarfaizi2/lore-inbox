Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUFALg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUFALg4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 07:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264986AbUFALg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 07:36:56 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:36548 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S264984AbUFALge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 07:36:34 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1 
In-reply-to: Your message of "Tue, 01 Jun 2004 04:26:16 MST."
             <20040601112616.GN2093@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 Jun 2004 21:36:22 +1000
Message-ID: <21845.1086089782@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2004 04:26:16 -0700, 
William Lee Irwin III <wli@holomorphy.com> wrote:
>On Tue, Jun 01, 2004 at 02:15:39AM -0700, Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc2/2.6.7-rc2-mm1/
>> - NFS server udpates
>> - md updates
>> - big x86 dmi_scan.c cleanup
>> - merged perfctr.  No documentation though :(
>> - cris architecture update
>
>Hmm. task_cpu() on UP seems to be missing a const.

I must remember, not everybody runs SMP ...  My bad.

