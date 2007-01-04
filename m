Return-Path: <linux-kernel-owner+w=401wt.eu-S1030203AbXADUtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbXADUtn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 15:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbXADUtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 15:49:43 -0500
Received: from 1wt.eu ([62.212.114.60]:1747 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030203AbXADUtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 15:49:43 -0500
Date: Thu, 4 Jan 2007 21:49:37 +0100
From: Willy Tarreau <w@1wt.eu>
To: Tomasz Krynicki <tomasz.krynicki@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACL support patch for > 2.4.29
Message-ID: <20070104204937.GQ24090@1wt.eu>
References: <ec8d0a9d0701040736j2d872a22ge65584a38bbfbd74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec8d0a9d0701040736j2d872a22ge65584a38bbfbd74@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 04, 2007 at 04:36:53PM +0100, Tomasz Krynicki wrote:
> Hi,
> does anyone have ACL support patch for newest kernels (ex 2.4.33, or
> better 2.4.34)?
> Last patch at http://acl.bestbits.at/ is for 2.4.29, seems this project
> died.

I still use it in my kernels, though I'm not 100% sure that they're free
of bugs right now. Last version is 0.8.73 for 2.4.29, and the patch still
applies to 2.4.33/2.4.34 (at least last time I did it).

Regards,
Willy

