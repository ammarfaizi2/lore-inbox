Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbTDJSAL (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 14:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTDJSAL (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 14:00:11 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:38121 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S264126AbTDJSAJ (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 14:00:09 -0400
Subject: Re: glibc+sysenter sources..?
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030409211042.GA29819@nevyn.them.org>
References: <1049913600.18782.24.camel@sparky>
	 <20030409211042.GA29819@nevyn.them.org>
Content-Type: text/plain
Organization: 
Message-Id: <1049998110.1263.50.camel@sparky>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Apr 2003 14:08:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-09 at 17:10, Daniel Jacobowitz wrote:
> On Wed, Apr 09, 2003 at 02:40:00PM -0400, Disconnect wrote:
> > I found the binaries (ftp://people.redhat.com/drepper/glibc/2.3.1-25/)
> > but the sources don't seem to be available.  (That makes it hard to
> > test, since my 2.5 system is running debian..)
> Just get a recent version of glibc.  2.3.2 includes the patches, I
> think.  That'll be in Debian/unstable in another week or so I bet.

Probably, but I'm running testing (I like it to at least -mostly- work
;) ..) and still would prefer the 2.3.1 patches.  (Among other things,
its easier to test changes if you do them in small batches; a libc
upgrade from 2.3.1 to 2.3.2 is hardly 'small'. And the 2.3.2 changelog
doesn't mention sysenter specifically, although I haven't read it in 
detail to see if its mentioned obliquely.)

Since the binaries are being distributed there, I had expected to find
sources in the same place.. or at least -somewhere-..

-- 
Disconnect <lkml@sigkill.net>

