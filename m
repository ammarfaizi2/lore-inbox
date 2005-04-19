Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVDSSZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVDSSZe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 14:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVDSSZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 14:25:34 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:50892 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261473AbVDSSZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 14:25:29 -0400
Date: Tue, 19 Apr 2005 14:25:29 -0400
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL violation by CorAccess?
Message-ID: <20050419182529.GT17865@csclub.uwaterloo.ca>
References: <20050419175743.GA8339@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419175743.GA8339@beton.cybernet.src>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 05:57:43PM +0000, Karel Kulhavy wrote:
> I have seen a device by CorAccess which apparently uses Linux and didn't find
> anything that would suggest it complies to GPL, though I had access to the
> complete shipping package. Does anyone know about known cause of violation by
> this company or should I investigate further?

Well what is the case if you use unmodified GPL code, do you still have
to provide sources to the end user if you give them binaries?  I would
guess yes, but IANAL.

As far as I can tell their system is a geode GX1 so runs standard x86
software.  Maybe they didn't have to modify any of the linux kernel to
run what they needed.  Their applications are their business of course.
It looks like they use QT as the gui toolkit, which I don't off hand
know the current license conditions of.  Then there is the web browser
and such, which has it's own license conditions.  Of course for all I
know their user manual has an offer of sending a CD with the sources if
you ask.  Does anyone actually have their product that could check for
that?

Len Sorensen
