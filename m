Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263812AbTDIU7L (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 16:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTDIU7I (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 16:59:08 -0400
Received: from crack.them.org ([65.125.64.184]:3202 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id S263812AbTDIU7F (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 16:59:05 -0400
Date: Wed, 9 Apr 2003 17:10:43 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Disconnect <lkml@sigkill.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: glibc+sysenter sources..?
Message-ID: <20030409211042.GA29819@nevyn.them.org>
Mail-Followup-To: Disconnect <lkml@sigkill.net>,
	lkml <linux-kernel@vger.kernel.org>
References: <1049913600.18782.24.camel@sparky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049913600.18782.24.camel@sparky>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 02:40:00PM -0400, Disconnect wrote:
> I found the binaries (ftp://people.redhat.com/drepper/glibc/2.3.1-25/)
> but the sources don't seem to be available.  (That makes it hard to
> test, since my 2.5 system is running debian..)
> 
> Preferable would be a patch against the standard 2.3.1 (rather than one
> against the redhat sources) but I can probably detangle it if needed.
> 
> Also, has this been tested under SMP or am I forging new ground? (dual
> ppro 200 system under 2.5.66-bk10.)

Just get a recent version of glibc.  2.3.2 includes the patches, I
think.  That'll be in Debian/unstable in another week or so I bet.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
