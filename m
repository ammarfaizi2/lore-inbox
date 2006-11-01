Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946096AbWKACFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946096AbWKACFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 21:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946389AbWKACFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 21:05:44 -0500
Received: from moci.net4u.de ([217.7.64.195]:42173 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S1946096AbWKACFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 21:05:44 -0500
From: Ernst Herzberg <earny@net4u.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc[1-4]: boot fail with (lapic && on_battery)
Date: Wed, 1 Nov 2006 03:05:33 +0100
User-Agent: KMail/1.9.1
Cc: Adrian Bunk <bunk@stusta.de>, mingo@redhat.com
References: <200610312227.54617.list-lkml@net4u.de> <20061101010406.GA27968@stusta.de>
In-Reply-To: <20061101010406.GA27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611010305.33990.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 November 2006 02:04, Adrian Bunk wrote:

> @Ingo:
> Any ideas?
>
>
> @Ernst:
> Thanks for your report.
> What model is your laptop?

It's a Thinkpad R50p

> Unless someone is able to spot the problem from your bug report, please
> do the following process of git bisecting for finding what broke it:
> ....
> After at about 12 reboots, ...

Will try, if i get a little spare time ;-)

Thanks,

<earny>
