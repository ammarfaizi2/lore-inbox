Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267923AbUH3Mxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267923AbUH3Mxr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 08:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267940AbUH3Mxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 08:53:47 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:32394 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267923AbUH3Mxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 08:53:43 -0400
Subject: Re: reverse engineering pwcx
From: Albert Cahalan <albert@users.sf.net>
To: Paul Jakma <paul@clubi.ie>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, clemtaylor@comcast.net, qg@biodome.org,
       rogers@isi.edu
In-Reply-To: <Pine.LNX.4.61.0408300836010.2441@fogarty.jakma.org>
References: <1093709838.434.6797.camel@cube>
	 <20040829210436.GA24350@hh.idb.hist.no>
	 <Pine.LNX.4.61.0408300836010.2441@fogarty.jakma.org>
Content-Type: text/plain
Organization: 
Message-Id: <1093870332.434.6983.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Aug 2004 08:52:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 03:42, Paul Jakma wrote:
> On Sun, 29 Aug 2004, Helge Hafting wrote:
> 
> > There's no need for faith or speculation here.
> > Put the chip under a microscope and count the pixels,
> > or rather measure their size and estimate their number.
> 
> The lavarnd guy did and counted 160x120:
> 
>  	http://slashdot.org/comments.pl?sid=119578&cid=10091208

Unless he explains a bit better, there's no reason
to assume he counted correctly. There may be a larger
pattern that was counted by mistake. For example,
there may be 160x120 red-sensing sub-pixels. He could
have counted only that.

Also, there is more than one type of sensor that can
be fitted to these webcam chips. They may vary.


