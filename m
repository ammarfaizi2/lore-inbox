Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265285AbUGSQDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbUGSQDW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 12:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUGSQDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 12:03:22 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:57052 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265285AbUGSQDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 12:03:21 -0400
Date: Tue, 20 Jul 2004 02:02:32 +1000
From: Nathan Scott <nathans@sgi.com>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.6.7
Message-ID: <20040720020231.B2406645@wobbly.melbourne.sgi.com>
References: <20040718155140.GA16760@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040718155140.GA16760@thundrix.ch>; from tonnerre@thundrix.ch on Sun, Jul 18, 2004 at 05:51:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2004 at 05:51:40PM +0200, Tonnerre wrote:
> Salut,
> 
> Jul 18 19:49:02 jules kernel: EIP is at pagebuf_daemon+0x180/0x2e0
> Jul 18 19:49:02 jules kernel: eax: d2389ec4   ebx: d2389ec4   ecx: d2389ec4   edx: d75ddf78
> Jul 18 19:49:02 jules kernel: esi: d3beeec4   edi: d7598000   ebp: d7599fd4   esp: d7599fd0
> Jul 18 19:49:02 jules kernel: ds: 007b   es: 007b   ss: 0068
> Jul 18 19:49:02 jules kernel: Process xfsbufd (pid: 14, threadinfo=d7598000 task=d75d6a10)

This is fixed in current bk and in CVS on oss.sgi.com.

cheers.

-- 
Nathan
