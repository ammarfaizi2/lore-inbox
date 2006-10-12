Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWJLSwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWJLSwV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWJLSwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:52:21 -0400
Received: from mail.impinj.com ([206.169.229.170]:56521 "EHLO earth.impinj.com")
	by vger.kernel.org with ESMTP id S1750731AbWJLSwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:52:21 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1-mm1
Date: Thu, 12 Oct 2006 11:52:19 -0700
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@google.com>,
       lkml <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>
References: <20061010000928.9d2d519a.akpm@osdl.org> <20061011144713.cb0c1453.akpm@osdl.org> <1160676589.9386.18.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1160676589.9386.18.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610121152.19649.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 October 2006 11:09, Badari Pulavarty wrote:
> create05 test hang goes away with hot-fix (revert-fd-table stuff).
> FYI.

Does it also go away with the "Eradicate fdarray overflow" patch instead of 
the hot-fix?

> Thanks,
> Badari

-- Vadim Lobanov
