Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263219AbUJ2K0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbUJ2K0i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 06:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbUJ2K0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 06:26:38 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:33744 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S263219AbUJ2KZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 06:25:17 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm2 (compiler warnings on x86_64)
Date: Fri, 29 Oct 2004 12:24:22 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20041029014930.21ed5b9a.akpm@osdl.org>
In-Reply-To: <20041029014930.21ed5b9a.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410291224.22676.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 of October 2004 10:49, Andrew Morton wrote:
> 
> 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm2/
> 

FYI, on x86_64 I've got quite a lot of compiler warnings from this kernel, 
although it's eventually compiled.

The full compilation log is available at:
http://www.sisk.pl/kernel/041029/2.6.10-rc1-mm2-compile.log
The corresponding .config is available at:
http://www.sisk.pl/kernel/041029/2.6.10-rc1-mm2.config

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
