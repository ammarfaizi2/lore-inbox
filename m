Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVBWURV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVBWURV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 15:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVBWURU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 15:17:20 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:45219 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261560AbVBWURJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 15:17:09 -0500
Date: Thu, 24 Feb 2005 07:16:29 +1100
From: Nathan Scott <nathans@sgi.com>
To: Sven Geggus <sven@geggus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xfsdump broken with Kernel 2.6.11-rc4
Message-ID: <20050224071629.A2517090@wobbly.melbourne.sgi.com>
References: <cvi7c2$a3o$1@benzin.geggus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <cvi7c2$a3o$1@benzin.geggus.net>; from sven@geggus.net on Wed, Feb 23, 2005 at 04:26:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 04:26:58PM +0100, Sven Geggus wrote:
> Hi there,
> 
> looks like xfsdumpis broken with recent 2.6.11-rc Kernels. 2.6.11-rc4 is the
> one I tried.
> 
> Strange enough ist does seem to work _sometimes_, but it does not work
> most of the time.
> 
> If it does not work I just get the following message:
> 
> xfsdump: ERROR: /dev/sda2 does not identify a file system

Can you send me the output from a failing run with the -v5 argument added?

thanks.

-- 
Nathan
