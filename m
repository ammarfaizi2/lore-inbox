Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbTLWWVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 17:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTLWWVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 17:21:12 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:42052 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S262925AbTLWWVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 17:21:09 -0500
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Rob Love'" <rml@ximian.com>,
       "'Jari Soderholm'" <Jari.Soderholm@edu.stadia.fi>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: DEVFS is very good compared to UDEV
Date: Tue, 23 Dec 2003 14:21:03 -0800
Organization: Cisco Systems
Message-ID: <008401c3c9a3$0d11abe0$ca41cb3f@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <1072216884.6987.52.camel@fur>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2003-12-23 at 16:20, Jari Soderholm wrote:
> 
> (please use a mailer that wraps lines, in the future)
> 
> > I am quite advanced Linux user who has used DEVFS quite
> > long time, and have also been a little suprised that it
> > has been marked OBSOLETE in 2.6 kernel.
> 
> devfs is marked obsolete for more reasons that just the presence of
> udev.  Devfs is also buggy, poorly designed, and unmaintained.

I do not care about devfs, and I believe/trust udev is a better
approach.

But I do have sth fair to say about this "unmaintained" part.

>From my memory, at some point in time, somebody (Al Viro?) reviewed
devfs code and flamed the author in public (klml), throwing lots of bad
impolite words to him, which I think was the biggest reason that the
author stopped maintaining it. This was one of the projects that got
killed by flames, or improper handling with flames (another one that
comes to mind is CML2).

Correct (but not flame :-) me if I am wrong.

