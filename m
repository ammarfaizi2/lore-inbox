Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUENRkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUENRkP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUENRkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:40:15 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:2192 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261914AbUENRkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:40:10 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Date: Fri, 14 May 2004 19:48:10 +0200
User-Agent: KMail/1.5
References: <20040513032736.40651f8e.akpm@osdl.org>
In-Reply-To: <20040513032736.40651f8e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405141948.10802.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 of May 2004 12:27, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-m
>m2/
>
>
> - Lots of VM changes - fixes from Andrea and generally moving things closer
>   to the -aa tree.
>
> - The x86_64 gcc-3.3.3 shipped with SuSE 9.1 miscompiles the post-2.6.6 CPU
>   scheduler changes, resulting in lockups after several minutes of heavy
> load. Hence this kernel refuses to build on gcc-3.3.x.  Please use
> gcc-3.4.0 if you're on x86_64.

Oh well.  And every distribution for x86_64 that I know ships with the 
gcc-3.3.x (sigh).

Can you please tell me where I can get the gcc-3.4 in RPM for SuSE 9.0 or 
FC2T3/AMD64?  I've bad memories of trying  to bulid the gcc myself from the 
sources ...

Yours,
RJW

