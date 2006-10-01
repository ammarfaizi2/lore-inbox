Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWJATZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWJATZx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 15:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWJATZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 15:25:53 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:49206 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932229AbWJATZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 15:25:52 -0400
Subject: Re: Announce: gcc bogus warning repository
From: Daniel Walker <dwalker@mvista.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061001192029.GD29920@ftp.linux.org.uk>
References: <1159717214.24767.3.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20061001111226.3e14133f.akpm@osdl.org> <452005E7.5030705@garzik.org>
	 <1159727188.24767.9.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <45200CC8.2030404@garzik.org>
	 <1159729113.24767.14.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20061001190034.GB29920@ftp.linux.org.uk>
	 <1159729390.24767.16.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20061001190740.GC29920@ftp.linux.org.uk>
	 <1159730035.24767.22.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20061001192029.GD29920@ftp.linux.org.uk>
Content-Type: text/plain
Date: Sun, 01 Oct 2006 12:25:50 -0700
Message-Id: <1159730750.24767.27.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-01 at 20:20 +0100, Al Viro wrote:
> On Sun, Oct 01, 2006 at 12:13:54PM -0700, Daniel Walker wrote:
> > On Sun, 2006-10-01 at 20:07 +0100, Al Viro wrote:
> > > On Sun, Oct 01, 2006 at 12:03:10PM -0700, Daniel Walker wrote:
> > > > > And that's better than the current situation in which respects, exactly?
> > > > 
> > > > Seeing the warnings is the current situation.
> > > 
> > > I bow to your incredible power of observation.  Now that you've shared
> > > that revelation with the list, could you explain what does blanket silencing
> > > of these warnings buy you, oh wan^H^Hise one?
> > 
> > Did you see me silencing anything (with your crystal ball?) ? Cause I'm
> > not.
> 
> And what, in your opinion, does the patch in question achieve if not
> that?

You mean the patch from Steven posted in May? Well it does appear to
silence the warning. You didn't like the approach it seems? Please tell
me why .

Daniel

