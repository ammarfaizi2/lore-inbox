Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131327AbRCSCem>; Sun, 18 Mar 2001 21:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131336AbRCSCeb>; Sun, 18 Mar 2001 21:34:31 -0500
Received: from ruthenium.btinternet.com ([194.73.73.138]:34280 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S131327AbRCSCeS>;
	Sun, 18 Mar 2001 21:34:18 -0500
Date: Mon, 19 Mar 2001 02:33:03 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon>
To: <asenec@senechalle.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: /proc/cpuinfo for Intel P4 D850GB
In-Reply-To: <200103190207.UAA13397@senechalle.net>
Message-ID: <Pine.LNX.4.31.0103190231270.5005-100000@athlon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Mar 2001 asenec@senechalle.net wrote:

> On a 2.0.36 kernel the above-referenced mb
> shows:
> ...
> Is the problem is due to the older 2.0.36 kernel,

Yes.

> or would the problem also present itself on a newer 2.2.x kernel?

Current 2.2 and 2.4 are both fixed for this problem.


This and a few other CPU related fixes should probably be backported
to 2.0 if someone has the spare time.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

