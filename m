Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbUKVTQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUKVTQZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbUKVTQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:16:18 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:27398 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S262367AbUKVTQA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:16:00 -0500
Message-ID: <41A23AEC.2060905@tebibyte.org>
Date: Mon, 22 Nov 2004 20:15:56 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm3
References: <20041121223929.40e038b2.akpm@osdl.org>
In-Reply-To: <20041121223929.40e038b2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Andrew Morton escreveu:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm3/

This (vanilla build, no patches) repeatedly panics on boot for me, just 
after mounting the (reiserfs) root partition read-only. I'm looking at 
why now. Assume it's a configuration error on my part, but I'm reporting 
it anyway in case you get other reports of this.

Regards,
Chris R.
