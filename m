Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264278AbUFCUrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUFCUrR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 16:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbUFCUrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 16:47:16 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:22498 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264283AbUFCUqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 16:46:47 -0400
Date: Thu, 03 Jun 2004 13:42:58 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Greg KH <greg@kroah.com>, "H. Peter Anvin" <hpa@zytor.com>
cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.6-rc2 RFT] Add's class support to cpuid.c
Message-ID: <106640000.1086295378@dyn318071bld.beaverton.ibm.com>
In-Reply-To: <20040603193256.GD23564@kroah.com>
References: <98460000.1086215543@dyn318071bld.beaverton.ibm.com> <40BE6CA9.9030403@zytor.com> <20040603193256.GD23564@kroah.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, June 03, 2004 12:32:56 PM -0700 Greg KH <greg@kroah.com> wrote:

>> As it is, it also mishandles the hotswap CPU scenario.
> 
> I agree, but that can be easily added with a second patch on top of this
> one, right Hanna?  :)
> 
> I'll go add this to the driver-2.6 bk tree to show up in the next -mm.

Thanks. Im working on it now.

Hanna

