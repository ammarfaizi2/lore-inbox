Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266837AbUIFKc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUIFKc3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 06:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267502AbUIFKc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 06:32:29 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:8680 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S266837AbUIFKc2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 06:32:28 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: Linux serial console patch
Date: Mon, 6 Sep 2004 10:32:27 +0000 (UTC)
Organization: Cistron
Message-ID: <chhebr$pta$1@news.cistron.nl>
References: <20040905175037.O58184@cus.org.uk> <413BA35C.8080705@superbug.demon.co.uk>
X-Trace: ncc1701.cistron.net 1094466747 26538 62.216.30.38 (6 Sep 2004 10:32:27 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton  <James@superbug.demon.co.uk> wrote:
>> I have read your posts to lkml containing your serial console flow control
>> patches firstly for 2.4.x and then for 2.6.x kernels.
>
>Does this fix junk being output from the serial console?
>If one is using Pentium 4 HT, it seems that both CPU cores try to send 
>characters to the serial port at the same time, resulting in lost 
>characters as one CPU over writes the output from the other.

We have multiple P4-HT enabled servers with debian installed & serial
console enabled (RPB++ ;-) and _i_ have never seen this behaviour.

Danny

-- 
"If Microsoft had been the innovative company that it calls itself, it 
would have taken the opportunity to take a radical leap beyond the Mac, 
instead of producing a feeble, me-too implementation." - Douglas Adams -

