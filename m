Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbTDUTpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 15:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTDUTpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 15:45:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1290 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261727AbTDUTpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 15:45:53 -0400
Date: Mon, 21 Apr 2003 20:57:54 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.68: NFS hang on write/close
Message-ID: <20030421205754.C7100@flint.arm.linux.org.uk>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030421164944.A7100@flint.arm.linux.org.uk> <16036.17639.765911.843996@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16036.17639.765911.843996@charged.uio.no>; from trond.myklebust@fys.uio.no on Mon, Apr 21, 2003 at 09:22:15PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 09:22:15PM +0200, Trond Myklebust wrote:
> ARM or does it also occur on i386?

ARM.  No idea about x86.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

