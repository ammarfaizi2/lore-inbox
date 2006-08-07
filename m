Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWHGBUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWHGBUt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 21:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWHGBUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 21:20:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:12646 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750867AbWHGBUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 21:20:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UuHSAuVDE+yU/TN6aoAta/7XQ4bAE0iZbZWD+eFn7dZ/CM775WoXGLrZnzNmhDcnxSKmi6YT0tf0H4/nHD8+0C8twlb4R3ed3emtwft1FLzakCYCJac3k0pb1K+PU4N4RyUsniCWHOx/J7lPKFpMvtFPthtMAsmHOwu108bM6OE=
Message-ID: <abcd72470608061820r4c313ebbw80e7cab98d5d2299@mail.gmail.com>
Date: Sun, 6 Aug 2006 18:20:47 -0700
From: "Avinash Ramanath" <avinashr@gmail.com>
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: Stat in kernel space
In-Reply-To: <abcd72470608061746o2810f895n9f9979f99c00d273@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <abcd72470608061746o2810f895n9f9979f99c00d273@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to know the file-size using stat.

On 8/6/06, Avinash Ramanath <avinashr@gmail.com> wrote:
> Could somebody let me know which function equivalent/header file is
> available in kernel space for "stat"ing?
> I want an equivalent of stat/lstat/fstat in kernel space.
>
> Thanks,
> Avinash.
>
