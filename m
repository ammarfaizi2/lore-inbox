Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWB0Pmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWB0Pmc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWB0Pmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:42:32 -0500
Received: from cantor.suse.de ([195.135.220.2]:47015 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964785AbWB0Pmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:42:31 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [Patch 3/4] Move the base kernel to 2Mb to align with TLB boundaries
Date: Mon, 27 Feb 2006 16:36:55 +0100
User-Agent: KMail/1.9.1
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1141053825.2992.125.camel@laptopd505.fenrus.org> <1141054297.2992.140.camel@laptopd505.fenrus.org>
In-Reply-To: <1141054297.2992.140.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602271636.56096.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 16:31, Arjan van de Ven wrote:
> As suggested by Andi (and Alan), move the default kernel location
> from 1Mb to 2Mb, to align to the start of a TLB entry.

I already have that and the head.S patch in my tree.

-Andi
