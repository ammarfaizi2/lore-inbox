Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbTLVPjZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 10:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264910AbTLVPjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 10:39:25 -0500
Received: from mail.humboldt.co.uk ([81.2.65.18]:27591 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S264890AbTLVPjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 10:39:23 -0500
Subject: Re: [OT] use of patented algorithms in the kernel ok or not?
From: Adrian Cox <adrian@humboldt.co.uk>
To: John Bradford <john@grabjohn.com>
Cc: Jamie Lokier <jamie@shareable.org>, Stan Bubrouski <stan@ccs.neu.edu>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200312220950.hBM9o7Xr000488@81-2-122-30.bradfords.org.uk>
References: <1071969177.1742.112.camel@cube>
	<20031221105333.GC3438@mail.shareable.org>
	<1072034966.1286.119.camel@duergar>
	<20031221215717.GA6507@mail.shareable.org> 
	<200312220950.hBM9o7Xr000488@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Dec 2003 15:34:15 +0000
Message-Id: <1072107256.28039.321.camel@newt>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-22 at 09:50, John Bradford wrote:
> Quote from Jamie Lokier <jamie@shareable.org>:
> 
> > That's why I said it's uncharted territory.  We don't know how safe it
> > is to publish code that *doesn't do anything* but does embody a
> > patented technique *only if the recipient deliberately modifies the
> > code*.
> 
> Look at the MTD code.

For examples of source code distribution in a patented area, look at
MPEG4 projects, particularly MPEG4IP.

http://mpeg4ip.sourceforge.net/ has source code under a variety of
licenses including GPL, and the front page has the following disclaimer:
"This code is not intended for end users, and does not contain
executables. Please read all the legal information to determine if it is
suitable for you."

The project was started by Cisco, who likely did some legal research
first. Cisco, however, have the resources to see off frivolous lawsuits,
while individual developers do not.

- Adrian Cox
http://www.humboldt.co.uk/


