Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264321AbUEIJXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbUEIJXY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 05:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbUEIJXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 05:23:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49360 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264321AbUEIJXX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 05:23:23 -0400
Date: Sun, 9 May 2004 10:23:20 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       dipankar@in.ibm.com, manfred@colorfullife.com, davej@redhat.com,
       wli@holomorphy.com, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       maneesh@in.ibm.com
Subject: Re: dentry bloat.
Message-ID: <20040509092320.GZ17014@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0405082143340.1592@ppc970.osdl.org> <Pine.LNX.4.44.0405091058300.2106-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405091058300.2106-100000@poirot.grange>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2004 at 11:10:30AM +0200, Guennadi Liakhovetski wrote:

> [OT, educational]: Do "." and ".." actually take dentries?

No.
