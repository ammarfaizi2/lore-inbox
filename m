Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTDNCVf (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 22:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbTDNCVe (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 22:21:34 -0400
Received: from siaag1ac.compuserve.com ([149.174.40.5]:61167 "EHLO
	siaag1ac.compuserve.com") by vger.kernel.org with ESMTP
	id S262710AbTDNCVe (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 22:21:34 -0400
Date: Sun, 13 Apr 2003 22:29:38 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Benefits from computing physical IDE disk geometry?
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304132233_MC3-1-3441-D4EF@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You couldn't even tell where such boundaries exist, or what the real
> block size of the underlying media is. Cyliners are all different sizes.


 Not even if you do timing tests?  I know people have done tests that
pinpoint where the xfer rate changes, for example.  I'm sure it
wouldn't be easy, but I bet you could get some useful information.
And at the very least, remapped sectors should be easy to spot...


--
