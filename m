Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263863AbTIIC3D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 22:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263884AbTIIC3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 22:29:03 -0400
Received: from trained-monkey.org ([209.217.122.11]:25616 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S263863AbTIIC3B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 22:29:01 -0400
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [Patch] asm workarounds in generic header files
References: <A609E6D693908E4697BF8BB87E76A07A022114BC@fmsmsx408.fm.intel.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 08 Sep 2003 22:27:55 -0400
In-Reply-To: <A609E6D693908E4697BF8BB87E76A07A022114BC@fmsmsx408.fm.intel.com>
Message-ID: <m3u17mitlg.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Suresh" == Siddha, Suresh B <suresh.b.siddha@intel.com> writes:

Suresh> Intel ecc compiler doesn't support inline assembly.  Attached
Suresh> patch is required to enable linux kernel build with Intel ecc
Suresh> compiler.  Please apply.

Hi Suresh,

It has always been the community policy that the kernel is compiled
with GCC. Therefore wouldn't it be more appropriate to ask Intel to
fix it's compiler than changing the kernel like this?

Cheers,
Jes
