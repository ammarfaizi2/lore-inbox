Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVCZAHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVCZAHn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 19:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVCZAHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 19:07:43 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:48091 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261881AbVCZAHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 19:07:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Fb1nMfAyLOvR49ZkSE6503sFbMwyz64gs1Jlt4XanaYRgV75+F9F5z5rUoWr24z3q7VWlLaPKzaAAWAGwnMGmaGokD8p8gA74JpdnPB7bPz5P3Fmy+GXoOxPEmN4fGPfZDXOcv/Xh6qJ/rFV81r2zpvWjzFBqFnmBLRyG+u61uc=
Message-ID: <21d7e99705032516071cdd586f@mail.gmail.com>
Date: Sat, 26 Mar 2005 11:07:38 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: C M <thevanquisher88@gmail.com>
Subject: Re: Feature Request Into Kernel - Savage DRM to be added as a selectable DRM module in the kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b264562605032508444ea330ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <b264562605032508444ea330ec@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was hopeing that it could be added as a selectable DRM module in the
> kernel such as the ati rage and such are. This is a tested driver,
> proven working for most, making it selectable in the kernel would be
> very much appreciated and a great advancment for all savage users. The
> savage users have for long been without opengl, now the time comes
> when it can happen, i was sincerley hoping that this could be added
> into the kernel. i was hoping it will become part in the list of
> selectable DRM in the gentoo kernel, vanilla, etc.. whatever it is
> easier to include it in. I would appericate a responce on your
> thoughts, and im here for testing if needed.
> 

Its on my list of things.. just not as high up as some other things..
it needs a full code review by a few people which means a lot of time,
it may also need to be cleaned up to kernel coding standards....

I might submit a patch for review soon...

Dave.
