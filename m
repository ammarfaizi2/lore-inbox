Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVFPVBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVFPVBb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 17:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVFPVBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 17:01:30 -0400
Received: from palrel12.hp.com ([156.153.255.237]:28088 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261827AbVFPVB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 17:01:27 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17073.59550.679017.387092@napali.hpl.hp.com>
Date: Thu, 16 Jun 2005 14:01:18 -0700
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andrew Morton <akpm@osdl.org>, Walt Drummond <drummond@valinux.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>,
       Stephane Eranian <eranian@hpl.hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [resend][PATCH] avoid signed vs unsigned comparison in efi_range_is_wc()
In-Reply-To: <Pine.LNX.4.62.0506162219040.2477@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506162219040.2477@dragon.hyggekrogen.localhost>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 16 Jun 2005 22:21:50 +0200 (CEST), Jesper Juhl <juhl-lkml@dif.dk> said:

  Jesper> I send in the patch below a while back but never recieved
  Jesper> any response.  Now I'm resending it in the hope that it
  Jesper> might be added to -mm.  The patch still applies cleanly to
  Jesper> 2.6.12-rc6-mm1

The patch looks fine to me.

	--david
