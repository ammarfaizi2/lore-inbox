Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWFIAW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWFIAW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 20:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWFIAW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 20:22:58 -0400
Received: from [198.99.130.12] ([198.99.130.12]:44266 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750925AbWFIAW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 20:22:57 -0400
Date: Thu, 8 Jun 2006 20:22:50 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Suzuki <suzuki@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Fix Compilation error for UM Linux
Message-ID: <20060609002250.GC10249@ccure.user-mode-linux.org>
References: <44883C68.8010307@in.ibm.com> <20060608104655.70c6836f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060608104655.70c6836f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2006 at 10:46:55AM -0700, Andrew Morton wrote:
> Really?  We often do arithmetic on void*.  Are you using gcc, with standard
> kbuild and standard compiler options?

I've never seen any gcc complaints from that piece of code, so I'm 
wondering the same thing.

				Jeff
