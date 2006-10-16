Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWJPKPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWJPKPn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWJPKPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:15:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:28863 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030346AbWJPKPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:15:20 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: remove pointless printk from i386 oops output
Date: Mon, 16 Oct 2006 12:01:59 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061006215245.GA15420@redhat.com>
In-Reply-To: <20061006215245.GA15420@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610161201.59507.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2006 23:52, Dave Jones wrote:
> This just got removed on x86-64, do the same on 32bit.
> It always annoyed me when this ate a line of oops output pushing
> interesting stuff off the screen.

Added thanks

-Andi
