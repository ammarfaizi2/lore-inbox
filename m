Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965233AbWADR3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965233AbWADR3G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbWADR3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:29:06 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:10430 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965235AbWADR3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:29:04 -0500
Subject: Re: 2.6.14.5 to 2.6.15 patch
From: Steven Rostedt <rostedt@goodmis.org>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060104171905.GM8079@torres.l21.ma.zugschlus.de>
References: <200601041710.37648.nick@linicks.net>
	 <20060104171905.GM8079@torres.l21.ma.zugschlus.de>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 12:29:01 -0500
Message-Id: <1136395741.12468.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 18:19 +0100, Marc Haber wrote:
> On Wed, Jan 04, 2006 at 05:10:37PM +0000, Nick Warne wrote:
> > A stupid question - buggered if I can find a kernel patch from 2.6.14.5 to 
> > 2.6.15?
> 
> You can try backing out the 2.6.14 -> 2.6.14.5 patch to generate a
> "pristine" 2.6.14 to which you can apply 2.6.14 -> 2.6.15.
> 
> This mess is one reason while I usually keep old kernel tarballs
> around for a while.

This mess is why I use ketchup:

http://www.selenic.com/ketchup/

-- Steve


