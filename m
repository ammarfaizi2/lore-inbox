Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVBPUzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVBPUzW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 15:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVBPUzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 15:55:21 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:13005 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261889AbVBPUzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 15:55:17 -0500
Date: Wed, 16 Feb 2005 21:51:22 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: a.hocquel@oreka.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange bug with realtek 8169 card
Message-ID: <20050216205122.GB18105@electric-eye.fr.zoreil.com>
References: <3yBMF-2kO-3@gated-at.bofh.it> <3yBMG-2kO-5@gated-at.bofh.it> <3yBMF-2kO-1@gated-at.bofh.it> <3yCfH-2Em-1@gated-at.bofh.it> <3yCfJ-2Em-7@gated-at.bofh.it> <3yCzf-2Rt-27@gated-at.bofh.it> <3yD2j-3mf-23@gated-at.bofh.it> <3yDbS-3tr-31@gated-at.bofh.it> <4213A5D5.8070802@oreka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4213A5D5.8070802@oreka.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre <a.hocquel_NOSPAM_@oreka.com> :
[...]
> thanks again, unfortunately PCs with those cards are at work, and from 
> today that's holidays until march 7th... :D

Excellent. Your testing will not impact the normal production.

I have done a minor update to sync with Jeff's latest -netdev
http://www.fr.zoreil.com/~romieu/misc/20050216-2.4.29-r8169.c-test.patch

--
Ueimor
