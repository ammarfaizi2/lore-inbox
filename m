Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbUJZGhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUJZGhh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 02:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbUJZGhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 02:37:37 -0400
Received: from hera.kernel.org ([63.209.29.2]:64394 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262113AbUJZGhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 02:37:15 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: The naming wars continue...
Date: Tue, 26 Oct 2004 06:37:08 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <clkrak$rtl$1@terminus.zytor.com>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <20041023030356.GA5005@animx.eu.org> <20041024133333.GA16901@hh.idb.hist.no> <20041025232654.GC30574@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1098772628 28598 127.0.0.1 (26 Oct 2004 06:37:08 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 26 Oct 2004 06:37:08 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20041025232654.GC30574@thundrix.ch>
By author:    Tonnerre <tonnerre@thundrix.ch>
In newsgroup: linux.dev.kernel
> 
> Salut,
> 
> On Sun, Oct 24, 2004 at 03:33:33PM +0200, Helge Hafting wrote:
> > Yes - lets stick to fewer numbers.  They can count faster, instead
> > of having a long string of them.  I hope linux doesn't
> > end up like X. "X11R6.8.1" The "X" itself is a counter, although
> > it is understandable if it never increments to "Y".  But
> > that "11" doesn't change much, and then there are three more numbers. :-/
> 
> X11  is the  name of  the  protocol: the  X Protocol,  version 11,  as
> released by the MIT. There was an X10.
> 

There also were a W, and and X1, X2, ... X11.

However, there is a tendency for numbers to get stuck (witness Linux
2.x).  In particular, X11R6 got encoded in many places including
pathnames for no good reason.  Under the pre-R6 naming schemes we'd
had R7 a long time ago.

	-hpa
