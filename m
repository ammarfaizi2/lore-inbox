Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbVHNKZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVHNKZa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 06:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbVHNKZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 06:25:30 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:37168 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932477AbVHNKZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 06:25:30 -0400
Message-ID: <42FF263A.8080009@gentoo.org>
Date: Sun, 14 Aug 2005 12:08:42 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IT8212/ITE RAID
References: <20050814053017.GA27824@zip.com.au>
In-Reply-To: <20050814053017.GA27824@zip.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT wrote:
> 1. Alan Cox's IDE driver that was included in his ac patchset, which
>    seems to have died at 2.6.11ac7.
> 2. A brief visit from a SCSI IDE driver in Andrew Mortons mm patchset.
>    It lived a brief but noted life before being taken out without any
>    reason (that I spotted) in 2.6.12-rc4-mm1

Alan's driver has been merged into 2.6.13. You can get the up-to-date patches 
here:

http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.12/2315_ide-no-lba.patch
http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.12/4345_it8212.patch

Daniel
