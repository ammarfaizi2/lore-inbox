Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422938AbWHZRmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422938AbWHZRmP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWHZRmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:42:15 -0400
Received: from main.gmane.org ([80.91.229.2]:21926 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964802AbWHZRmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:42:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Peter" <sw98234@hotmail.com>
Subject: Re: wrt: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Date: Sat, 26 Aug 2006 17:41:53 +0000 (UTC)
Message-ID: <ecq151$9t3$2@sea.gmane.org>
References: <ecpru4$9t3$1@sea.gmane.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pool-70-106-95-181.pskn.east.verizon.net
X-Archive: encrypt
User-Agent: pan 0.109 (Beable)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug 2006 16:12:52 +0000, Peter wrote:

> Using 2.6.17.11 with reiser4 patch only. Voluntary preempt.
> 
> Recently, I have been receiving this sequence of errors:
> 
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown

snip....

I should mention that I have an 80 pin IDE cables, and did try replacing
it. Same result. This problem is new, so I do not believe the cable is the
issue -- esp since manu diags show all is well.

-- 
Peter
+++++
Do not reply to this email, it is a spam trap and not monitored.
I can be reached via this list, or via 
jabber: pete4abw at jabber.org
ICQ: 73676357

