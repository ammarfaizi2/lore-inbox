Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbUJYSV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUJYSV6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 14:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUJYSUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:20:09 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:35029 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261160AbUJYSSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 14:18:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=U/nCLo9P4Uy/jRkjy1AkWr3CDHetVxovNB9ka6LXv4SkYOtBr56/Qq067Pb5jaOmRRqXetHH/sqO36zVMtkTFMX3KR+INz3YMNKWGW/tGHDjZ+h35G/LW9L5+nU+BgVRPZQD2Qf/zUJYNVOG7xBo0X0vshnVbQm6jMxaG1uSYyQ=
Message-ID: <9e47339104102511182f916705@mail.gmail.com>
Date: Mon, 25 Oct 2004 14:18:43 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>, Larry McVoy <lm@bitmover.com>,
       akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <20041025162022.GA27979@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4d8e3fd3041019145469f03527@mail.gmail.com>
	 <20041023161253.GA17537@work.bitmover.com>
	 <4d8e3fd304102403241e5a69a5@mail.gmail.com>
	 <20041024144448.GA575@work.bitmover.com>
	 <4d8e3fd304102409443c01c5da@mail.gmail.com>
	 <20041024233214.GA9772@work.bitmover.com>
	 <20041025114641.GU14325@dualathlon.random>
	 <1098707342.7355.44.camel@localhost.localdomain>
	 <20041025133951.GW14325@dualathlon.random>
	 <20041025162022.GA27979@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004 09:20:22 -0700, Larry McVoy <lm@bitmover.com> wrote:
> That's strange, I wonder why you think BK doesn't help.  The prevailing
> wisdom is that it has helped.  It's well documented by third parties
> who have nothing to do with you or me.

>From what I see BitKeeper has definitely helped the kernel development
processes. On the other hand BitKeeper has been stable for the last
couple of years. Are we going to see any large changes in BK any time
soon? For example BK could be extended to handle the workflow AndrewM
does. Another extension would be for moving signed patches through the
system to help avoid another SCO problem. Any hints on where the
future is going? Can BK be extended to further automate the kernel
development workflow?

-- 
Jon Smirl
jonsmirl@gmail.com
