Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbTEFDML (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 23:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbTEFDMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 23:12:10 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:17280 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S262335AbTEFDMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 23:12:07 -0400
Date: Tue, 6 May 2003 13:26:28 +1000
From: CaT <cat@zip.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-bk7: Where oh where have my sensors gone? (i2c)
Message-ID: <20030506032627.GA524@zip.com.au>
References: <20030427115644.GA492@zip.com.au> <20030428205522.GA26160@kroah.com> <20030505083458.GA621@zip.com.au> <20030505165848.GA1249@kroah.com> <3EB6AA01.30601@wmich.edu> <20030505182648.GA1826@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505182648.GA1826@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 11:26:48AM -0700, Greg KH wrote:
> Which is what should be showing up on CaT's machine (of the lm75 device
> is on his hardware.)

Yes. And ofcourse it isn't so I feel like a right boob. Now, compiling
the right sensor (adm) gets it registered and promptly crashes the
kernel. Once this happened whilst in the kernel, either mid scroll of
the fb or mid write of a new line on screen and another time this
happened mid-fsck (no partitions needed fscking). Witht he wrong/no
sensors module in the kernel runs just fine.

My experience with the sensors code is evolving. :)

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
