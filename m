Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWEBASg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWEBASg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 20:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWEBASg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 20:18:36 -0400
Received: from test-iport-1.cisco.com ([171.71.176.117]:56982 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751269AbWEBASf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 20:18:35 -0400
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 2 of 13] ipath - set up 32-bit DMA mask if 64-bit setup fails
X-Message-Flag: Warning: May contain useful information
References: <1906950392f7ef8c7d07.1145913778@eng-12.pathscale.com>
	<ada7j55vayj.fsf@cisco.com>
	<4B05D10C-407E-46A5-848F-0897D1E6D1CD@kernel.crashing.org>
	<adapsixs9rg.fsf@cisco.com>
	<114102B4-FBCB-4A5A-B986-80D4A730DD91@kernel.crashing.org>
	<aday7xlqqaf.fsf@cisco.com>
	<C5B86DAC-A8B2-4EF1-9C61-89125707DF92@kernel.crashing.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 01 May 2006 17:18:34 -0700
In-Reply-To: <C5B86DAC-A8B2-4EF1-9C61-89125707DF92@kernel.crashing.org> (Segher Boessenkool's message of "Tue, 2 May 2006 02:13:59 +0200")
Message-ID: <ada64kpqnxh.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 May 2006 00:18:35.0023 (UTC) FILETIME=[F38001F0:01C66D7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Segher> Oh, that.  Right.  It's about time I get my whole MSI
    Segher> patch set into shape for submission here, yes.

OK, that explains everything ;)

So the ipath driver with a PCIe device works on a PowerMac G5? Cool.

 - R.
