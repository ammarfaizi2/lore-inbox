Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTE2Scl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 14:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbTE2Scl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 14:32:41 -0400
Received: from 213-4-13-153.uc.nombres.ttd.es ([213.4.13.153]:8454 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262489AbTE2Scl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 14:32:41 -0400
Subject: Re: 2.5.70-mm2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030529103628.54d1e4a0.akpm@digeo.com>
References: <170EBA504C3AD511A3FE00508BB89A920221E5FF@exnanycmbx4.ipc.com>
	 <20030529103628.54d1e4a0.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1054233955.690.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 29 May 2003 20:45:56 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-29 at 19:36, Andrew Morton wrote:
> Some of these use fsync()-based synchronisation and won't benefit, but they
> may have compile-time or runtime options to use O_SYNC instead.
> 
> 
> Apart from that, just using the kernel in day-to-day activity is the most
> important thing.  If everyone does that, and everyone is happy then by
> definition this kernel is a wrap.

I'm already happy with 2.5.70 :-)

