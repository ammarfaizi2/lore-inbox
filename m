Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVBATrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVBATrt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 14:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVBATrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 14:47:49 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:28852 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262116AbVBATrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 14:47:48 -0500
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-os@analogic.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0502011303350.7089@chaos.analogic.com>
References: <2.416337461@selenic.com>
	 <1107191783.21706.124.camel@winden.suse.de> <41FE6B42.7010807@grupopie.com>
	 <1107280438.12050.118.camel@winden.suse.de>
	 <Pine.LNX.4.61.0502011303350.7089@chaos.analogic.com>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1107287266.12050.131.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 01 Feb 2005 20:47:47 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 19:11, linux-os wrote:
> This uses an GNU-ISM where you are doing pointer arithmetic
> on a pointer-to-void. NotGood(tm) [...]

That's perfectly fine inside the kernel.

-- Andreas.

