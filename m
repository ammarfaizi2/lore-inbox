Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVBPVKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVBPVKU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 16:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVBPVKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 16:10:20 -0500
Received: from [64.4.37.14] ([64.4.37.14]:49736 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S262021AbVBPVKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 16:10:15 -0500
Message-ID: <BAY10-F14B0FF7B5E49C3F0D01902D66C0@phx.gbl>
X-Originating-IP: [61.247.245.18]
X-Originating-Email: [agovinda04@hotmail.com]
In-Reply-To: <52zmy4w74a.fsf@topspin.com>
From: "govind raj" <agovinda04@hotmail.com>
To: roland@topspin.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Customized 2.6.10 kernel on a Compact Flash
Date: Thu, 17 Feb 2005 02:38:39 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 16 Feb 2005 21:09:01.0928 (UTC) FILETIME=[BD432E80:01C5146B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your immediate response. We are just having a single partition 
(hda0) in Compact Flash. We are using /sbin/init as our init process (We 
have /linuxrc as a soft link to /sbin/init).

Regards

Govind


>From: Roland Dreier <roland@topspin.com>
>To: "govind raj" <agovinda04@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: Customized 2.6.10 kernel on a Compact Flash
>Date: Wed, 16 Feb 2005 13:02:45 -0800
>
>     govid> Kernel panic - not syncing: Attempted to kill init!
>
>It seems your kernel is booting fine, but your init process is exiting
>(which leads to this message).  What userspace do you have installed
>on your compact flash card?  In particular what are you using as "init"?
>
>  - Roland

_________________________________________________________________
Start you business on Baazee today! 
http://adfarm.mediaplex.com/ad/ck/4686-26272-10936-31?ck=RegSell Register 
for Free!

