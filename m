Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263574AbUFCMsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUFCMsR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 08:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbUFCMsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 08:48:17 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:18632 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263574AbUFCMsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 08:48:16 -0400
Date: Thu, 3 Jun 2004 05:48:08 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm2 - hpet-dont-use-new-major borked
Message-Id: <20040603054808.26df2102.pj@sgi.com>
In-Reply-To: <20040603015356.709813e9.akpm@osdl.org>
References: <20040603015356.709813e9.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the broken out patch set, the patch:

  hpet-dont-use-new-major.patch

is junk - no recognizable patch to be applied.

Dropping it from the patch set works - at least
the other patches, including hpet*, apply ok.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
