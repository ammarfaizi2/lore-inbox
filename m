Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266330AbUFQBDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266330AbUFQBDR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 21:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266323AbUFQBDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 21:03:17 -0400
Received: from palrel10.hp.com ([156.153.255.245]:4491 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S266330AbUFQBDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 21:03:13 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16592.60876.886257.165633@napali.hpl.hp.com>
Date: Wed, 16 Jun 2004 18:03:08 -0700
To: Balazs Scheidler <bazsi@balabit.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel oops on ia64 (2.6.6 + 0521 ia64 patch)
In-Reply-To: <1087420973.4345.19.camel@bzorp.balabit>
References: <1087420973.4345.19.camel@bzorp.balabit>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Balazs> I'm encountering more-or-less reproducible oopses on a 2.6.6
  Balazs> kernel with 0521 ia64 patch, compiled with gcc 3.3.3 on
  Balazs> Debian sarge.

  Balazs> The box is a HP rx2600 with a single processor, kernel is
  Balazs> compiled in UP mode. Here is the backtrace (saved off froma
  Balazs> terminal session on the network console, thus the
  Balazs> formatting, but the info should be correct).

Does the oops go away with an SMP kernel?

	--david
