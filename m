Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbUCZS4Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUCZSxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:53:53 -0500
Received: from lpbproductions.com ([68.98.208.147]:31656 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S261518AbUCZSwt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:52:49 -0500
From: "Matt H." <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm3
Date: Fri, 26 Mar 2004 11:52:52 -0700
User-Agent: KMail/1.5.94
References: <40631649.9070000@blueyonder.co.uk>
In-Reply-To: <40631649.9070000@blueyonder.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403261152.52237.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same results here... Forze at ' Free unused kernel memory ". I'm using an 
Athlon 3000+ , and reiserfs.. 

Matt H.


On Thursday 25 March 2004 10:26 am, you wrote:
> Builds OK on Athlon  XP2200+, but froze at Freeing unused kernel memory:
> 180k freed. SysRQ-B and on reboot, it got past that poing then froze
> solid later on. This is from boot.omsg, hope to gather more data later.
> <6>Freeing unused kernel memory: 180k freed
> <4>Removing [35127 37455 0x0 SD]..done
> <4>Removing [3904 35127 0x0 SD]..done
> <4>There were 2 uncompleted unlinks/truncates. Completed
> <6>Adding 3823460k swap on /dev/hda2.  Priority:42 extents:1
> <4>hdb: Speed warnings UDMA 3/4/5 is not functional.          ### THE
> CDROM ###
> Kernel logging (ksyslog) stopped.
> Kernel log daemon terminating.
> Regards
> Sid.
