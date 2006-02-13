Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWBMKzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWBMKzJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWBMKzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:55:09 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:36584 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932161AbWBMKzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:55:07 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.16-rc3
Date: Mon, 13 Feb 2006 21:54:13 +1100
User-Agent: KMail/1.9.1
Cc: Avuton Olrich <avuton@gmail.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <3aa654a40602130231p1c476e99paa986fa198951839@mail.gmail.com> <20060213023925.2b950eea.akpm@osdl.org>
In-Reply-To: <20060213023925.2b950eea.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602132154.15187.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 21:39, Andrew Morton wrote:
> That looks like a different cpufreq bug.  Unfortunately the critical first
> few lines have scrolled away.  Please boot with `vga=extended' so we get to
> see them.

Just as a suggestion, why don't we print oopsen out in the opposite direction 
so the critical information is in the last few lines and the stacktrace in 
reverse, or have that as a bootparam option oops=reverse .

Cheers,
Con
