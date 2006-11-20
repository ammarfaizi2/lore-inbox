Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755893AbWKTLNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893AbWKTLNw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 06:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756134AbWKTLNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 06:13:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:12293 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1755893AbWKTLNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 06:13:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KGQ3aDM1xfNpMtpuTqzLB/xAB282ZXEN04XUSUGKcCVXhVevjTkpXycnRFiduB5C2Z7prPgNkm9LvwKfFuNiGk723dEyTDRga3a3xcaAGt9MAEEbqpYQHLRQ7tbNkt72q5diMt2WV2EUeRSVYjyPVF7OvVp/MR+WABev0e3gPoc=
Message-ID: <21d7e9970611200313u767dfa6dxe84a38affa732f80@mail.gmail.com>
Date: Mon, 20 Nov 2006 22:13:49 +1100
From: "Dave Airlie" <airlied@gmail.com>
To: "Paolo Ornati" <ornati@fastwebnet.it>
Subject: Re: GoogleEarth triggers 99% System Load... DRI/X problem?
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20061120115613.04676c09@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061120115613.04676c09@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/06, Paolo Ornati <ornati@fastwebnet.it> wrote:
> Sometimes, when using GoogleEarth, X gets stuck (only the cursor can go
> around).
>
> Kernel version: it's not a new thing, I've seen this happen for quite
> some time (oh, and the -dirty in my current kernel is just because of
> a fix for APIC: http://lkml.org/lkml/2006/11/18/84).
>
>

It's a GPU crash, better off on dri-devel mailing lists as it involves
the 3D driver and googleearth crashing it.. attach an xorg.conf and
Xorg.0.log....

Dave.
