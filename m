Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269112AbUHXXRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269112AbUHXXRo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 19:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269100AbUHXXNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 19:13:38 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:40345 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S269109AbUHXXJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 19:09:47 -0400
Date: Wed, 25 Aug 2004 01:07:13 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Gaetan Leurent <gaetan.leurent@ens.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible bug in ext3 journalling (kernel 2.6.8.1)
Message-ID: <20040824230713.GA13179@electric-eye.fr.zoreil.com>
References: <qlk7jro1p5s.fsf@thym.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qlk7jro1p5s.fsf@thym.ens.fr>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gaetan Leurent <gaetan.leurent@ens.fr> :
[...]
> I'm running a 2.6.8.1 kernel with supermount-ng patch.
[...]
> My proc was a bit overclocked so it could be a hardware problem, but I
> don't think so because I didn't notice other problems.
> 
> Can I do anything to help ?

Reproduce the bug with a decently clocked cpu on a machine where
the nvidia proprietary module has not been loaded since last fsck.

Until then, chances are high that any analysis is considered a
waste of time.

--
Ueimor
