Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTISBjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 21:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTISBjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 21:39:40 -0400
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:15313 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S262251AbTISBjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 21:39:39 -0400
Date: Thu, 18 Sep 2003 20:39:10 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Re: 2.6.0-test5 usbserial oops
Message-ID: <20030919013910.GA1343@glitch.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030911044650.GA10064@kroah.com> <20030911175755.GA13334@kroah.com> <20030911223224.GA1345@glitch.localdomain> <20030918040955.GB2849@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030918040955.GB2849@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 09:09:55PM -0700, Greg KH wrote:
> > I'm still getting an (apparently) identical oops.  I've attached the
> > ksymoops output (your patch was applied for this one), along with the
> > debugging messages you requested previously.  Let me know if I can
> > provide any additional info.
> 
> Does this happen on 2.6.0-test5-bk3?

I can confirm that this is still an issue on 2.6.0-test5-bk5... I
didn't test -bk3 explicitly (although I certainly will if you like), as
I assume that any relevant changes will be in -bk5 as well.  The oops
appears to be essentially identical, so I'm omitting it and the debug
output in order to conserve bandwidth.  If you want to see it anyway,
just let me know.

Thanx!
