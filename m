Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264393AbRFHXrj>; Fri, 8 Jun 2001 19:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264409AbRFHXr3>; Fri, 8 Jun 2001 19:47:29 -0400
Received: from t2.redhat.com ([199.183.24.243]:755 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S264408AbRFHXrQ>; Fri, 8 Jun 2001 19:47:16 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200106082254.f58MsWE487361@saturn.cs.uml.edu> 
In-Reply-To: <200106082254.f58MsWE487361@saturn.cs.uml.edu> 
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 09 Jun 2001 00:46:58 +0100
Message-ID: <22400.992044018@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


acahalan@cs.uml.edu said:
>  Consider a chunk of x86 instructions using a home-grown OS
> abstraction layer, and drivers that implement that layer for both
> Linux and any non-GPL operating system. The binary blob is obviously
> not derived from Linux, and may in fact run without modification in a
> BSD or Solaris/x86 kernel.

> There is in fact just such a layer. It might not currently have the
> features needed to implement TCP, but it could be extended as needed.

Sounds like you're talking about UDI. I thought that had died the horrible
slow death it deserved - only to be dusted off, redone in CPU-agnostic
bytecode and called ACPI.

--
dwmw2


