Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbVJ0HCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVJ0HCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 03:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbVJ0HCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 03:02:12 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52102 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932576AbVJ0HCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 03:02:12 -0400
Subject: Re: Linux Kernel MD5 sums and some question
From: Lee Revell <rlrevell@joe-job.com>
To: Chaitanya Hazarey <c.v.hazarey@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a9abfb40510262356o5de2a638pa15d0c8e9dda2833@mail.gmail.com>
References: <9a9abfb40510262356o5de2a638pa15d0c8e9dda2833@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 03:01:01 -0400
Message-Id: <1130396462.19492.13.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-27 at 12:26 +0530, Chaitanya Hazarey wrote:
> Hi all,
> 
> Lately I had some problems compiling the kernel source on my machine.
> I guess nothing serious, but one thing came to my notice. I was
> looking for the MD5 sums for the linux kenerl and found none. The Pgp
> signatures are fine , but there seems no way to check the package.
> 
> The next question I would like to ask is that, how to I go
> incrementally from linux kernel version 2.6.12.6 to 2.6.13 as no
> patches seem to be provided for it.

Revert the 2.6.12 -> 2.6.12.6 patch then apply the 2.6.13 patch to your
2.6.12 tree.

Lee

