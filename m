Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWIAKod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWIAKod (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 06:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWIAKoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 06:44:32 -0400
Received: from rutherford.zen.co.uk ([212.23.3.142]:47535 "EHLO
	rutherford.zen.co.uk") by vger.kernel.org with ESMTP
	id S1751444AbWIAKoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 06:44:32 -0400
Message-ID: <44F80F0D.70100@zen.co.uk>
Date: Fri, 01 Sep 2006 11:44:29 +0100
From: Grant Wilson <grant.wilson@zen.co.uk>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc5-mm1
References: <20060901015818.42767813.akpm@osdl.org>
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-Rutherford-IP: [82.71.45.175]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/
[snip]
>  The CONFIG_BLOCK changes wrecked these.

The CONFIG_BLOCK changes also seem to prevent the selection of any RAID
or LVM drivers...

Cheers,
Grant
