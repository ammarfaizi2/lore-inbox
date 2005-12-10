Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbVLJDjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVLJDjg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 22:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbVLJDjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 22:39:36 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:20498 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S964905AbVLJDjf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 22:39:35 -0500
Date: Fri, 9 Dec 2005 23:31:22 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Paulo da Silva <psdasilva@esoterica.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: STILL Cannot run linux 2.6.14.3 UML on a x86_64
Message-ID: <20051210043122.GC14269@ccure.user-mode-linux.org>
References: <43924B2C.9000300@esoterica.pt> <20051204043205.GA15425@ccure.user-mode-linux.org> <43926CC8.2030902@esoterica.pt> <20051204162732.GA3692@ccure.user-mode-linux.org> <43978E04.7030000@esoterica.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43978E04.7030000@esoterica.pt>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 01:36:04AM +0000, Paulo da Silva wrote:
> Cannot get it running !!!
> It stops, consuming variable amounts of cpu.
> The same configuration works perfectly on a 32 bits system.

> [42949373.490000] request_module: runaway loop modprobe binfmt-464c
> [42949373.490000] request_module: runaway loop modprobe binfmt-464c
> [42949373.490000] request_module: runaway loop modprobe binfmt-464c
> [42949373.490000] request_module: runaway loop modprobe binfmt-464c
> [42949373.490000] request_module: runaway loop modprobe binfmt-464c

You never answered my question about whether this was a 32 or 64 bit
filesystem.

				Jeff
