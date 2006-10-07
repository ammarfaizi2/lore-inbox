Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932868AbWJGVkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932868AbWJGVkY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 17:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932870AbWJGVkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 17:40:24 -0400
Received: from mail-ale01.alestra.net.mx ([207.248.224.149]:18311 "EHLO
	mail-ale01.alestra.net.mx") by vger.kernel.org with ESMTP
	id S932868AbWJGVkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 17:40:23 -0400
Message-ID: <45281E90.2080502@att.net.mx>
Date: Sat, 07 Oct 2006 16:39:28 -0500
From: Hugo Vanwoerkom <rociobarroso@att.net.mx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: ocilent1@gmail.com
CC: Chris Wedgwood <cw@f00f.org>, Lee Revell <rlrevell@joe-job.com>,
       Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       linux list <linux-kernel@vger.kernel.org>, dsd@gentoo.org
Subject: sound skips on 2.6.18-ck1
References: <200606181204.29626.ocilent1@gmail.com> <20060719063344.GA1677@tuatara.stupidest.org> <44BE37E8.2040706@att.net.mx>
In-Reply-To: <44BE37E8.2040706@att.net.mx>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I see that on 2.6.18-ck1 still some sort of quirks patch is needed for 
VIA chips.

I get plenty:

ALSA: underrun, at least 0ms.

and with 2.6.17-ck1 with the quirks.c.patch I did not. But the patch 
does not fit on 2.6.18 :-(

Strangely enough this time around I do *not* get underruns on vt's with 
mpg321 and I *do* get them on X. Last time around it was the reverse.

Is there a fix for 2.6.18 ?

Thanks!

Hugo
