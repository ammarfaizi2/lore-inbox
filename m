Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266310AbTBTR0s>; Thu, 20 Feb 2003 12:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266308AbTBTR0s>; Thu, 20 Feb 2003 12:26:48 -0500
Received: from griffon.mipsys.com ([217.167.51.129]:219 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S266320AbTBTR0q>;
	Thu, 20 Feb 2003 12:26:46 -0500
Subject: Re: SMP-Linux
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Buchanan <jamesbuch@iprimus.com.au>
Cc: "John W. M. Stevens" <john@betelgeuse.us>, linux-kernel@vger.kernel.org
In-Reply-To: <005601c2d11f$bfe5e060$59951ad3@windows>
References: <001501c2d11a$3ad9c3a0$59951ad3@windows>
	 <20030210160848.GB30804@morningstar.nowhere.lie>
	 <005601c2d11f$bfe5e060$59951ad3@windows>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045762740.12534.110.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 20 Feb 2003 18:39:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-10 at 17:16, James Buchanan wrote:

> Yes, a HAL, very much, but not really a VM, only a very thin layer of
> architecture-nuturalness.  Very thin.  The trickery I have learnt from
> the NetBSD project is that it has some very clever glue code below
> this HAL.  I suppose to maintain acceptable performance levels.  Then
> again the goals of NetBSD and Linux are different in some respects,
> Linux likes raw speed and was originally only for the x86 and NetBSD
> likes portability above that.
> 
> So I suppose my experiment will never really take off, but could have
> some interesting results!

Well... how do you think linux actually works ? Did you bother
_reading_ the code before proposing to do something that is
basically already there ? :)

Ben (happily running SMP on PowerPC architecture).

Ben.
