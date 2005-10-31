Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbVJaF5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVJaF5E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 00:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVJaF5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 00:57:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4494 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932281AbVJaF5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 00:57:00 -0500
Date: Mon, 31 Oct 2005 00:56:48 -0500
From: Dave Jones <davej@redhat.com>
To: Grant Coady <gcoady@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci_ids: remove non-referenced symbols from pci_ids.h
Message-ID: <20051031055648.GA4795@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Grant Coady <gcoady@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200510290000.j9T00Bqd001135@hera.kernel.org> <20051031024217.GA25709@redhat.com> <436591A5.20609@gmail.com> <20051031041313.GA1939@redhat.com> <4365AAEE.9000409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4365AAEE.9000409@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 04:26:06PM +1100, Grant Coady wrote:
 > Dave Jones wrote:
 > > At least 2 distros are carrying patches removing the BROKEN attribute
 > > on the advansys Kconfig for some architectures. The users of those kernels
 > > using their advansys controllers without any issue at all.
 > 
 > So why are your driver patches not in mainline then?

Because it serves as a reminder that it needs fixing.

		Dave

