Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264165AbTDJUtR (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 16:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264166AbTDJUtR (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 16:49:17 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:25823 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S264165AbTDJUtQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 16:49:16 -0400
Subject: Re: glibc+sysenter sources..?
From: Steven Cole <elenstev@mesatop.com>
To: Disconnect <lkml@sigkill.net>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1049998110.1263.50.camel@sparky>
References: <1049913600.18782.24.camel@sparky>
	 <20030409211042.GA29819@nevyn.them.org>  <1049998110.1263.50.camel@sparky>
Content-Type: text/plain
Organization: 
Message-Id: <1050008432.24463.69.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 10 Apr 2003 15:00:32 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 12:08, Disconnect wrote:
> On Wed, 2003-04-09 at 17:10, Daniel Jacobowitz wrote:
> > On Wed, Apr 09, 2003 at 02:40:00PM -0400, Disconnect wrote:
> > > I found the binaries (ftp://people.redhat.com/drepper/glibc/2.3.1-25/)
> > > but the sources don't seem to be available.  (That makes it hard to
> > > test, since my 2.5 system is running debian..)
> > Just get a recent version of glibc.  2.3.2 includes the patches, I
> > think.  That'll be in Debian/unstable in another week or so I bet.
> 
> Probably, but I'm running testing (I like it to at least -mostly- work
> ;) ..) and still would prefer the 2.3.1 patches.  (Among other things,
> its easier to test changes if you do them in small batches; a libc
> upgrade from 2.3.1 to 2.3.2 is hardly 'small'. And the 2.3.2 changelog
> doesn't mention sysenter specifically, although I haven't read it in 
> detail to see if its mentioned obliquely.)
> 
> Since the binaries are being distributed there, I had expected to find
> sources in the same place.. or at least -somewhere-..

Try here: ftp://ftp.gnu.org/gnu/glibc/

Steven

