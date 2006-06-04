Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750710AbWFDQLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWFDQLg (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 12:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWFDQLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 12:11:36 -0400
Received: from wx-out-0102.google.com ([66.249.82.200]:9338 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750710AbWFDQLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 12:11:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FwEo6ZCsgCzz7nC33cb7UKPyhgGxt8hhceAsq1u7w1hx0L+CLB2ZkN5uw6lxV6m8tK3gqEc/BwDcFYMmwyYXerpoz+mIWN48VMH9/Zp22HSDHHCPv1WiVXjKVZ0BD5uvD/SBycabs7BA+0MwmfoaHRYfEloFsbsfZA40hBD3v38=
Message-ID: <beee72200606040911w6cd035a9j5d1a647254e053d7@mail.gmail.com>
Date: Sun, 4 Jun 2006 18:11:35 +0200
From: "davor emard" <davoremard@gmail.com>
To: "Alistair John Strachan" <s0348365@sms.ed.ac.uk>
Subject: Re: SMP HT + USB2.0 crash
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606041706.28073.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <beee72200606040322w2960e5f9j1716addc39949ccb@mail.gmail.com>
	 <200606041706.28073.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/06, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> On Sunday 04 June 2006 11:22, davor emard wrote:
> > Usually SMP + EHCI crashes like this
>
> Please attach another log without NVIDIA ever having being loaded. This is a
> technical forum, we need precise facts "nvidia has not been loaded", not
> vague recollections "nvidia probably wasn't loaded some time before".
>
> Secondly, I highly recommend running memtest86 on your system for at least a
> couple of passes. You can download an ISO from the homepage and boot it from
> a CD. If this fails, you have faulty memory.
>
> --
> Cheers,
> Alistair.
>
> Third year Computer Science undergraduate.
> 1F2 55 South Clerk Street, Edinburgh, UK.
>
