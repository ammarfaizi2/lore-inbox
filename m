Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264590AbTFKXTV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 19:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbTFKXTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 19:19:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:254 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S264590AbTFKXTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 19:19:20 -0400
Subject: Re: 2.5.70-mm8: freeze after starting X
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030611154122.55570de0.akpm@digeo.com>
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
	 <20030611154122.55570de0.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1055374476.673.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 11 Jun 2003 16:34:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 15:41, Andrew Morton wrote:

> You might try reverting
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm8/broken-out/pci-init-ordering-fix.patch
>
> Something oopsed I'd say.  You using radeon?  That seems pretty oopsy
> lately.

I will debunk both theories: its not Radeon (I have a Matrox) and its
not the pci-init-ordering-fix patch (I already tried that).

	Robert Love

