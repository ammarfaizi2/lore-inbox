Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbTDNDfR (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 23:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbTDNDfR (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 23:35:17 -0400
Received: from siaag1ad.compuserve.com ([149.174.40.6]:16626 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S262726AbTDNDfQ (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 23:35:16 -0400
Date: Sun, 13 Apr 2003 23:44:51 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Benefits from computing physical IDE disk geometry?
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304132346_MC3-1-3441-4D4C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:


> You couldn't even tell where such boundaries exist, or what the real
> block size of the underlying media is. Cyliners are all different sizes.


  Found this by accident while skimming a new book; haven't visited yet
but it may be of interest:

    A technical report describing Skippy and two other disk drive
microbenchmarks (run in seconds or minutes rather than hours or days)
is at

      http://sunsite.berkeley.edu/
             Dienst/UI/2.0/Describe/ncstrl.ucb/CSD-99-1063

(Hennessey & Patterson 3rd ed., Ch.7, exercise 5.)


--
 "Let's fight till six, and then have dinner," said Tweedledum.
  --Lewis Carroll, _Through the Looking Glass_
