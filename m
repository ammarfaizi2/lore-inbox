Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270050AbUJSWlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270050AbUJSWlX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269475AbUJSWgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:36:33 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:34456 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269861AbUJSWdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:33:20 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mQlctyaadMY7e8KatArWyYzMzv/LSHLnOSfIUQadt6aP5PCE2LucPQXllnoPIHOyzP8OyIbYLVLqanX95dHCi9qYWBSTGuVf4K1rP0A2YWRYvr7byNpDeSBDqu12+aF3F+sv/mY0n0jWbFZzjxFOYC4JoXVFA3ccexxeg/6xnGI
Message-ID: <9e473391041019153348d4c6c@mail.gmail.com>
Date: Tue, 19 Oct 2004 18:33:19 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Russell Miller <rmiller@duskglow.com>
Subject: Re: 2.6.9 DRM compile problem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200410191719.35057.rmiller@duskglow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410191613.35691.rmiller@duskglow.com>
	 <9e4733910410191514db82abc@mail.gmail.com>
	 <200410191719.35057.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004 17:19:34 -0500, Russell Miller <rmiller@duskglow.com> wrote:
> Hmm.  I didn't see an option to turn it off, though I will look again.
> 
> And how do I find out which are broken so I don't post to this list and make
> an @$$ out of myself again?

Code maturity level options
   Select only drivers expected to compile cleanly

Controls the BROKEN flags.

-- 
Jon Smirl
jonsmirl@gmail.com
