Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261511AbTCGKDh>; Fri, 7 Mar 2003 05:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261512AbTCGKDh>; Fri, 7 Mar 2003 05:03:37 -0500
Received: from griffon.mipsys.com ([217.167.51.129]:57078 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S261511AbTCGKDg>;
	Fri, 7 Mar 2003 05:03:36 -0500
Subject: Re: [patch] oprofile for ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: oprofile-list@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org,
       Segher Boessenkool <segher@koffie.nl>, o.oppitz@web.de,
       afleming@motorola.com, linux-kernel@vger.kernel.org
In-Reply-To: <200303070929.h279TGTu031828@saturn.cs.uml.edu>
References: <200303070929.h279TGTu031828@saturn.cs.uml.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047032003.12206.5.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Mar 2003 11:13:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 10:29, Albert D. Cahalan wrote:
> This is basic timer profiling for ppc, tested on the
> 2.5.62 linuxppc kernel. It's a port of the ppc64 code.

I'm sure I missed something... but I fail to see the the
interest in profiling based on sampling the instruction ptr
on a 100 Hz basis. This is way to slow to give any useful
results imho

Ben.

