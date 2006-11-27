Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757762AbWK0KQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757762AbWK0KQD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 05:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757768AbWK0KQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 05:16:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:21679 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1757765AbWK0KQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 05:16:01 -0500
From: Andi Kleen <ak@suse.de>
To: "Zhao Forrest" <forrest.zhao@gmail.com>
Subject: Re: Which patch fix the 8G memory problem on x64 platform?
Date: Mon, 27 Nov 2006 11:15:55 +0100
User-Agent: KMail/1.9.5
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <ac8af0be0611270202i54e376b5jedf91fd7cba35434@mail.gmail.com>
In-Reply-To: <ac8af0be0611270202i54e376b5jedf91fd7cba35434@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611271115.55899.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 November 2006 11:02, Zhao Forrest wrote:
> Hi Andi,
> 
> The kernel 2.6.18.3 runs very well on my x64 server with 2 CPU's and
> 8G memory; however kernel 2.6.16.32 kernel panic(Kernel panic - not
> syncing: Attempted to kill init) under the stress test. After I use
> mem=4000M for kernel 2.6.16.32, the kernel panic doesn't happen under
> stress test.

I'm not aware of a "8G memory problem"

Best you write a full bug report and possibly git bisect it.

-Andi
 
