Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbVKVCU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbVKVCU6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 21:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbVKVCU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 21:20:58 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:28493 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964864AbVKVCU5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 21:20:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m9xPTavXqqTmnPy7Zqd5wx5mKRA6vtcKvnxASbyqsL1ERnD36o5W032V0sqDwkWAcp8XI8npV2I6Es+EKVXDAsyd8mTRGmIXMVKZ1aAAFRTplRaUwXgE2DQkqH6kJWXUoH7rSFAi5sFXcnkUbDe1SN8lgy2CVO40k952czhfQVY=
Message-ID: <9e4733910511211820x3539213arfe20f3939a375b51@mail.gmail.com>
Date: Mon, 21 Nov 2005 21:20:56 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] Small PCI core patch
Cc: Dave Airlie <airlied@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1132623268.20233.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
	 <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
	 <1132623268.20233.14.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-11-22 at 11:47 +1100, Dave Airlie wrote:
> Nvidia are at least trying to do what they can within what for them is
> not a very easy set of market conditions for open sourcing. ATI were
> doing very nice things until they won the Xbox 360 contract. An
> observation that perhaps would not go amiss reaching the US legal
> watchdogs.

How is graphics going to be dealt with on Linux? Is the Linux desktop
going to stay stuck in 1998 since that is the last year the graphics
vendors released specs? If the choice is "open source or die" then
that's the answer. Of course that answer is bad news desktop Linux
distributions and they may die.

If the choice instead is to embrace current graphics hardware, then
given the current state of the market, I don't see any other
alternative than using the proprietary drivers and OpenGL stacks. The
path in that direction is something like Xgl.  We can wish for a
non-proprietary choice on the current hardware, but the reality is
that we are not going to get it.

--
Jon Smirl
jonsmirl@gmail.com
