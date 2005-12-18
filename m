Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932660AbVLRCUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbVLRCUA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 21:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbVLRCUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 21:20:00 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:51689 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932660AbVLRCUA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 21:20:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e4n2/t5jxJckb0FHa1jxODheC800wCrXLOGBMh82RLKMWTp0SK75IEeD5f+8SVFqhhvYk40DCINr/Qcgk/2F6BbfKcozArOTulNGLTAS6lgk5I3opeq68KT0RJ/Rqn8+vaenUjAeoWb2FxoV1Ge+kXt7c2Q7href8iV9H/Y3xkM=
Message-ID: <758a2bbf0512171819j6a9400cflf3d53951fe35a67a@mail.gmail.com>
Date: Sat, 17 Dec 2005 18:19:58 -0800
From: Vijay Sampath <vsampath@gmail.com>
To: gcoady@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MTD (kernel 2.4.32): kernel stuck in tight loop occasionally on flash access
In-Reply-To: <758a2bbf0512171759i35df21e7t8a1b00f72c362614@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <02DAE179D5CEED4C992055C823ED90FF8ACE8E@ex1>
	 <758a2bbf0512171759i35df21e7t8a1b00f72c362614@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/05, Vijay Sampath <vsampath@gmail.com> wrote:
> >         Leaves me confused :)  Description and patch should match?
>
> Description has a typo. Patch is accurate. Unless somebody more
> knowledgeable than me on the intricacies would want to differ.
>
> >         Something is wrong here?  Your patch should not alter dontdiff.
>
> It didn't. 2.4 kernel doesn't have dontdiff, so I had to download it.
> But I only downloaded to one of the directories, hence the messed up
> output. Maybe dontdiff should have "dontdiff" as one of the files not
> to diff! :)
>
> Thanks,
>
> Vijay
>
