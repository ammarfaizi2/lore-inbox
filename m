Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266912AbUJFEMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbUJFEMw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 00:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUJFEMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 00:12:52 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:36549 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266912AbUJFEMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 00:12:36 -0400
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive
	(SCSI-libsata, VIA SATA))
From: Lee Revell <rlrevell@joe-job.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Robert Love <rml@novell.com>,
       Roland Dreier <roland@topspin.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4163660A.4010804@pobox.com>
References: <4136E4660006E2F7@mail-7.tiscali.it>
	 <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com>
	 <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au>
	 <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost>
	 <20041006015515.GA28536@havoc.gtf.org> <41635248.5090903@yahoo.com.au>
	 <20041006020734.GA29383@havoc.gtf.org>
	 <20041006031726.GK26820@dualathlon.random>  <4163660A.4010804@pobox.com>
Content-Type: text/plain
Message-Id: <1097035953.1359.15.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 06 Oct 2004 00:12:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 23:27, Jeff Garzik wrote:
> If users and developers are presented with the _impression_ that long 
> latency code paths don't exist

Users do not care whether some "long latency code path" exists in
theory.  They only notice results.  The developer part of your argument
is valid though.

Lee 

