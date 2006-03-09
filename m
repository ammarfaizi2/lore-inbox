Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWCIMHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWCIMHv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWCIMHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:07:50 -0500
Received: from lucidpixels.com ([66.45.37.187]:2751 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932158AbWCIMHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:07:49 -0500
Date: Thu, 9 Mar 2006 07:07:41 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
cc: linux-scsi@vger.kernel.org
Subject: Linux SCSI Error Question with SG Driver
Message-ID: <Pine.LNX.4.64.0603090706370.15616@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a tape library connected to a Linux box here and every once and a 
while I see these in dmesg:

sg_low_free: bad mem_src=0, buff=0xdb6a8000, rqSz=32768
sg_low_free: bad mem_src=0, buff=0xdb6b0000, rqSz=28672
sg_low_free: bad mem_src=0, buff=0xdb738000, rqSz=32768
sg_low_free: bad mem_src=0, buff=0xdb718000, rqSz=28672
sg_low_free: bad mem_src=0, buff=0xdb680000, rqSz=32768
sg_low_free: bad mem_src=0, buff=0xdb678000, rqSz=28672
sg_low_free: bad mem_src=0, buff=0xdb670000, rqSz=32768
sg_low_free: bad mem_src=0, buff=0xdb668000, rqSz=28672
sg_low_free: bad mem_src=0, buff=0xdb660000, rqSz=32768
sg_low_free: bad mem_src=0, buff=0xdb658000, rqSz=28672
sg_low_free: bad mem_src=0, buff=0xdb650000, rqSz=32768
sg_low_free: bad mem_src=0, buff=0xdb648000, rqSz=28672

Does anyone know what they refer to?

A quick google and newsgroup search just turn out the actual snippets of 
code that produce these errors, thanks..

Justin.

