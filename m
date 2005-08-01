Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVHAQPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVHAQPE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 12:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVHAQMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 12:12:35 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:14560 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S262230AbVHAQLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 12:11:00 -0400
Subject: Re: [PATCH] optimize writer path in time_interpolator_get_counter()
From: Alex Williamson <alex.williamson@hp.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, tony.luck@intel.com
In-Reply-To: <Pine.LNX.4.62.0508010906250.6397@schroedinger.engr.sgi.com>
References: <1122911571.5243.23.camel@tdi>
	 <Pine.LNX.4.62.0508010906250.6397@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: LOSL
Date: Mon, 01 Aug 2005 10:10:57 -0600
Message-Id: <1122912657.5243.25.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 09:06 -0700, Christoph Lameter wrote:
> Could we remove some code duplication?

   Works for me.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

