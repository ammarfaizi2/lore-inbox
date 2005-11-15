Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVKOGPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVKOGPN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 01:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVKOGPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 01:15:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23982 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932283AbVKOGPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 01:15:11 -0500
Date: Tue, 15 Nov 2005 00:06:58 -0500
From: Dave Jones <davej@redhat.com>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051115050658.GA13660@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
	Lee Revell <rlrevell@joe-job.com>,
	Robert Hancock <hancockr@shaw.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <58MJb-2Sn-37@gated-at.bofh.it> <58NvO-46M-23@gated-at.bofh.it> <58Rpx-1m6-11@gated-at.bofh.it> <58UGF-6qR-27@gated-at.bofh.it> <58UQf-6Da-3@gated-at.bofh.it> <437933B6.1000503@shaw.ca> <1132020468.27215.25.camel@mindpipe> <20051115032819.GA5620@redhat.com> <43795575.9010904@wolfmountaingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43795575.9010904@wolfmountaingroup.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 08:26:45PM -0700, Jeff V. Merkey wrote:

 > NetWare used 16K stacks in kernel by default.

unsubscribe netware-kernel

