Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWIIOpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWIIOpA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 10:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWIIOpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 10:45:00 -0400
Received: from ns1.suse.de ([195.135.220.2]:9384 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932230AbWIIOo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 10:44:59 -0400
From: Andi Kleen <ak@suse.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch -mm] s390: fix save_stack_trace
Date: Sat, 9 Sep 2006 15:36:48 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20060908011317.6cb0495a.akpm@osdl.org> <20060908121626.GC6913@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060908121626.GC6913@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609091536.49113.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 September 2006 14:16, Heiko Carstens wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
>
> x86_64-mm-stacktrace-cleanup.patch reverses the logic in s390's
> save_stack_trace incorrectly. Fix this.

I added the patch to the original patch thanks
-Andi
