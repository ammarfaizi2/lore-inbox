Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbTH2KAS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 06:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTH2KAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 06:00:18 -0400
Received: from uni03du.unity.ncsu.edu ([152.1.13.103]:1664 "EHLO
	uni03du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S264505AbTH2KAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 06:00:15 -0400
From: jlnance@unity.ncsu.edu
Date: Fri, 29 Aug 2003 06:00:11 -0400
To: root@mauve.demon.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lockless file readingu
Message-ID: <20030829100011.GA663@ncsu.edu>
References: <E19sUna-0003Zq-00@calista.inka.de> <200308282344.AAA26603@mauve.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308282344.AAA26603@mauve.demon.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 12:44:00AM +0100, root@mauve.demon.co.uk wrote:

> Of course it dowesn't.
> The probability gets rather smaller as numbers go down, and bigger as
> they go up.
> With 2^128 bits, the chance of a a collision between 2^64 randomly chosen 
> pictures is 50%.
> At 2^54 pictures, it's about one in a million, and at 2^34 (enough for
> several pictures of everyone alive) one in a billion billion.
> At more common numbers of pictures (say 2^14) it becomes vanishingly
> unlikely for anyone to have two matching pictures (even with several billion
> archives)

Be careful.  I remember discussing in probability class the liklyhood that
two people in a room with N people have the same birthday.  N does not have
to be anywhere close to 365 for your probability of a collision to be greater
than 50%.  I forget what the exact number is but its less than 30.  The
image problem sounds similar, depending on exactly how you phrase it.

Thanks,

Jim
