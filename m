Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWEQS5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWEQS5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWEQS5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:57:38 -0400
Received: from wx-out-0102.google.com ([66.249.82.199]:6036 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750957AbWEQS5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:57:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Gwr2P9WoZPWZFJgRWh3CGNnhKs/3ACJ6FrHi1sNTqScdpztG57nBimqLxH/exNVtoaa/6GvaAfsmfQpAJCDylgumhxAnRmmT2P9RVnQbZ2FxrkdVK5F2KmX51WEqxNzPha+vna2GjQmW7iogMc9QGCswYPY5ZURuZ6+QtEdzkRk=
Date: Wed, 17 May 2006 15:57:32 -0300
From: Alberto Bertogli <albertito@gmail.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [UML] Problems building and running 2.6.17-rc4 on x86-64
Message-ID: <20060517185732.GF693@gmail.com>
References: <20060514182541.GA4980@gmail.com> <20060516191244.GB6337@ccure.user-mode-linux.org> <20060517023942.GI9066@gmail.com> <200605170836.41009.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605170836.41009.blaisorblade@yahoo.it>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 08:36:40AM +0200, Blaisorblade wrote:
> On Wednesday 17 May 2006 04:39, Alberto Bertogli wrote:
> > On Tue, May 16, 2006 at 03:12:44PM -0400, Jeff Dike wrote:
> > Here it is. While the patch worked, it was for 2.6.16, and I'm using
> > 2.6.17-rc4, I hope that's not a problem.
> 
> Guess not - I'll test this patch soon because I have the same problem, however 
> are you running a 2.6.16 host?
> 
> If so, can you verify whether on a 2.6.15 host kernel the same binary runs 
> fine (as is the case for me)?

I'm running 2.6.17-rc4 host.

I'll boot 2.6.16 and 2.6.15 later tonight and I'll let you know. Is
there any additional kernel you want me to try as host/uml?

Thanks,
		Alberto


