Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267261AbTGNLV0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 07:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270077AbTGNLV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 07:21:26 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54209
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S267261AbTGNLVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:21:25 -0400
Subject: Re: Linux v2.6.0-test1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <200307141139.h6EBd09g000700@81-2-122-30.bradfords.org.uk>
References: <200307141139.h6EBd09g000700@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058182417.561.47.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 12:33:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-14 at 12:39, John Bradford wrote:
> > > > The point of the test versions is to make more people realize that they
> > > > need testing
> > > 
> > > Are all the known security issues in 2.4 now fixed in 2.6.0-test1?
> >
> > No, and several more have been added in 2.6-test only.
> 
> As far as I know, they are only information disclosure ones, not
> directly exploitable vulnerabilities, or am I wrong?

Last time I checked there were remote DoS attacks and local root attacks
present in 2.5.7x

> > > This has been the only major reason for keeping of most of my
> > > production machines running 2.4 for quite a while.  If not, can we get
> > > the fixes in at the earliest opportunity?
> >
> > Sure.. send the fixes to Linus
> 
> Is anybody even keeping track of this, though?  Picking thorough LKML
> to see what did and didn't go in doesn't seem particularly exciting to
> me.

Then you'll just have to wait a few months

