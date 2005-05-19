Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVESSIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVESSIa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 14:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVESSIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 14:08:30 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:23054 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261194AbVESSI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 14:08:27 -0400
Date: Thu, 19 May 2005 14:01:55 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/9] UML - small fixes left over from rc4
Message-ID: <20050519180155.GA7020@ccure.user-mode-linux.org>
References: <200505180420.j4I4K5CS017303@ccure.user-mode-linux.org> <20050518052940.GE29811@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518052940.GE29811@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 06:29:40AM +0100, Al Viro wrote:
> Wrong.  If you want it to work, you need 0x80000000 here (or changed START
> in x86_64 makefile.

Oops, missed that.  That'll be in the next set of patches.

				Jeff
