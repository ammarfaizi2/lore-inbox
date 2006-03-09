Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751916AbWCIPND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbWCIPND (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 10:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbWCIPND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 10:13:03 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:43493 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751916AbWCIPNC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 10:13:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qr0srkUAmjt+ZL6lPGccZondtuUeyj8K/3JSZPG3Dh1BULVq2qgYlVHrd+SacC7968vt+1ATD2D1PtTgLM+mee3SrngULGNu6XDL6PEyudE9qhDmrW8CnQMrKh9Y+u3XMsMONGcZkCylgVW2x75b0P6qtswOKMrZPzzDhONQh/U=
Message-ID: <161717d50603090713r50471974tb0089863324e88c0@mail.gmail.com>
Date: Thu, 9 Mar 2006 10:13:00 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: davids@webmaster.com
Subject: Re: [future of drivers?] a proposal for binary drivers.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIELAKJAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <161717d50603080659t53462cd0k53969c0d33e06321@mail.gmail.com>
	 <MDEHLPKNGKAHNMBLJOLKIELAKJAB.davids@webmaster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/06, David Schwartz <davids@webmaster.com> wrote:
>
> Dave Neuer wrote:
>
> > What is linux-specific in this context is that many people, like
> > myself, who have contributed code to the kernel under the GPL *don't
> > want* their code to be used in non-free software, period. Someone who
> > wants to leverage my work needs to do it under the terms that I allow.
> > That is the law. Whining is not going to change my mind.
>
>        I'm sorry, that's not the law. You can wish it was, but it's not.
>
>        If the law allowed you to give your software away for free and then put
> restrictions on use, you could drop copies of a poem from an airplane (or
> put it up on a billboard) and then demand royalties from everyone who read
> it.

Right. Copyright law doesn't allow me to demand royalties from the
people who read my dropped-from-airplane poem. Copyright law *does*
say that I can prevent people from copying my dropped-from-airplane
poem and re-publishing it, however. Copyright law also absolutely
gives me monopoly power over derivitive works - you can't even create
a work derived from my dropped-from-airplane poem without my
permission, much less distribute one.

But let's not keep torturing the analogy. We're talking about
software, in particular driver software which is presumably (and here
a court gets to decide whether the presumption is true, not driver
authors) a derived work of the kernel on which it depends. Many, many
kernel developers have repeatedly stated their reservations of their
rights under copyright law and the GPL with regard to derived works on
this forum and elsewhere.

Best regards,
Dave
