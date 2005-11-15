Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbVKOQgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbVKOQgl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbVKOQgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:36:41 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:47523 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964870AbVKOQgl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:36:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kF2OfgwtGNjXrcuPNCzwuBc6cVHBsYe+ePqlfpZD3lJXuomw+fbuRs7bvd9nao6byX+dmxSISCIylDoRTZvPAtf2wXX9oLYRv639LNYwMuOiy+bUcO8ky/KV6u4/fO1IAGt2OsiA3fGPMs0+vnt13AFbTprICTxsm7upNUy7YLY=
Message-ID: <5bdc1c8b0511150836r396ccb2fk91a27dc0b8bd8804@mail.gmail.com>
Date: Tue, 15 Nov 2005 08:36:40 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rt13
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051115090827.GA20411@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051115090827.GA20411@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/05, Ingo Molnar <mingo@elte.hu> wrote:
> i have released the 2.6.14-rt13 tree, which can be downloaded from the
> usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>
> lots of fixes in this release affecting all supported architectures, all
> across the board. Big MIPS update from John Cooper.
<SNIP>

2.6.14-rt13 is up and running here. Everything looks fine in the first
couple of hours. Nothing negative to report.

Please let me know if there are any particular features that you'd
like me to look at on an AMD64 machine.

Cheers,
Mark
