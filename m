Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVAGSye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVAGSye (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVAGSye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 13:54:34 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:10385 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261527AbVAGSyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 13:54:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KKYGuQ0ZUb60Z8zafWrVMQYUAj2yIS7C72YP8f0XQe0g7kPjD+UljsIpJfM21RoLPDG8qJpWl2tizwyqxVY/llcc4Nt1nijQstXAfmYImk/oMhswfMbGaWiFzf+h1XAJZKDubuXLiQ6xo+bf3VPx/4BBSbITTTPrwFo8965isrg=
Message-ID: <5b64f7f0501071054589f451f@mail.gmail.com>
Date: Fri, 7 Jan 2005 13:54:22 -0500
From: Rahul Karnik <deathdruid@gmail.com>
Reply-To: Rahul Karnik <deathdruid@gmail.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: 2.6.x features log
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <41DEC82C.4040502@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41DEC82C.4040502@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2005 09:34:36 -0800, Randy.Dunlap <rddunlap@osdl.org> wrote:

> What I'm seeing (and getting a little concerned about,
> although I dislike PR with a passion) is that the 2.6.x
> continuous development cycle will cause us (the Linux
> community) to miss logging some of these important new
> features (outside of bk).  Has anyone kept a track of new
> features that are being added in 2.6?

Personally speaking, the key feature of the Halloween document was not
documenting what new features we had in the kernel -- it was the
ability to see what _user-visible_ changes there were. As a
"mainstream" user, I might not care much about a new O(1) scheduler,
but I might be affected by the removal of (say) ipchains.

Thanks,
Rahul
