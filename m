Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751923AbWFUBor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbWFUBor (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbWFUBor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:44:47 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:3971 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1751923AbWFUBoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:44:46 -0400
Date: Tue, 20 Jun 2006 18:43:59 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: Chris Wright <chrisw@sous-sol.org>, stable@kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [stable] [-stable PATCH] UML - fix uptime
Message-ID: <20060621014359.GN22737@sequoia.sous-sol.org>
References: <200606202225.k5KMP3U5006871@ccure.user-mode-linux.org> <20060620225522.GK22737@sequoia.sous-sol.org> <20060621004930.GA8274@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621004930.GA8274@ccure.user-mode-linux.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Dike (jdike@addtoit.com) wrote:
> On Tue, Jun 20, 2006 at 03:55:22PM -0700, Chris Wright wrote:
> > * Jeff Dike (jdike@addtoit.com) wrote:
> > > The use of unsigned instead of unsigned here broke the calculations on
> >              ^^^^^^^^            ^^^^^^^^
> > Hard to imagine how that would cause a problem ;-)
> 
> Heh, feel free to fix.

Thanks, I did when I queued it up.
-chris
