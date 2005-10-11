Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbVJKA0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVJKA0p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 20:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVJKA0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 20:26:45 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:48134 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751309AbVJKA0o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 20:26:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ai/1MofrVSoJbbBmG0qJPkmeKV4IO4ZFrk+Nde0oExPRUizVv/g9tVy+xEOk67RE8V5B082LpMH5tFxKyWqWo+nTCja+TsFdIITSO7bGCHVTC365PS0ESXIaM1WOYq/Ld5NseuCD77s6GUE+31GlPB411L23t6KAnzMEmo6j1Wc=
Message-ID: <21d7e9970510101726h5bf920f0y3b7c42a6ff98734e@mail.gmail.com>
Date: Tue, 11 Oct 2005 10:26:41 +1000
From: Dave Airlie <airlied@gmail.com>
To: Lars Roland <lroland@gmail.com>
Subject: Re: Direct Rendering drivers for ATI X300 ?
Cc: Gerhard Mack <gmack@innerfire.net>, linux-kernel@vger.kernel.org
In-Reply-To: <4ad99e050510101200m6f3e1abh7ff8fb6b08b3c0e6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0510101230360.8804@innerfire.net>
	 <4ad99e050510101200m6f3e1abh7ff8fb6b08b3c0e6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> What are your dmesg reporting, when loading the modules, if you see
> something along these lines:
>

For PCI Express Radeon cards:

The kernel portions are in my -git tree ready for pushing to Linus
after the next release is made,

The userspace portions requires X.org/Mesa/DRM CVS trees.

The DRM CVS also contains the kernel portions....

Dave.
