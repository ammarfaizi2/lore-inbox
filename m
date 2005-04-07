Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbVDGRsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVDGRsF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVDGRsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:48:05 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:12229 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262531AbVDGRsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:48:00 -0400
Date: Thu, 7 Apr 2005 10:47:47 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Phillips <phillips@istop.com>, Paul Mackerras <paulus@samba.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050407174747.GA9663@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <16980.55403.190197.751840@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0504070747580.28951@ppc970.osdl.org> <200504071300.51907.phillips@istop.com> <Pine.LNX.4.58.0504071023190.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504071023190.28951@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 10:38:06AM -0700, Linus Torvalds wrote:

> So my prefernce is _overwhelmingly_ for the format that Andrew uses
> (which is partly explained by the fact that I am used to it, but
> also by the fact that I've asked for Andrew to make trivial changes
> to match my usage).
>
> That canonical format is:
>
> 	Subject: [PATCH 001/123] [<area>:] <explanation>
>
> together with the first line of the body being a
>
> 	From: Original Author <origa@email.com>
>
> followed by an empty line and then the body of the explanation.

Having a script to check people get this right before sending it via
email would be a nice thing to put into scripts/ or probably
Documentation/ perhaps?

Does such a thing already exist?
