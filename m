Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbUBZNTy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 08:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbUBZNTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 08:19:54 -0500
Received: from slask.tomt.net ([217.8.136.223]:55477 "EHLO pelle.tomt.net")
	by vger.kernel.org with ESMTP id S262795AbUBZNTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 08:19:53 -0500
Message-ID: <403DF26E.8020908@tomt.net>
Date: Thu, 26 Feb 2004 14:19:42 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Mark Watts <m.watts@eris.qinetiq.com>
Subject: Re: Serial ATA (SATA) status report
References: <403D5B3D.6060804@pobox.com> <200402260913.15379.m.watts@eris.qinetiq.com>
In-Reply-To: <200402260913.15379.m.watts@eris.qinetiq.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Watts wrote:
> Which one of these chips are the 3Ware cards based on?

None of them. 3ware has its own chip, supported by the 3w-xxxx driver in 
mainline 2.4 and 2.6. It's basicly exports the logical arrays as SCSI 
devices.
