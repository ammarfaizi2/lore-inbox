Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269294AbTCDHOO>; Tue, 4 Mar 2003 02:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269296AbTCDHOO>; Tue, 4 Mar 2003 02:14:14 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:41432 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S269294AbTCDHON>; Tue, 4 Mar 2003 02:14:13 -0500
Date: Tue, 4 Mar 2003 08:24:43 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add checkstack Makefile target
Message-ID: <20030304072443.GA5503@wohnheim.fh-wedel.de>
References: <20030303211647.GA25205@wohnheim.fh-wedel.de> <20030304070304.GP4579@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030304070304.GP4579@actcom.co.il>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 March 2003 09:03:04 +0200, Muli Ben-Yehuda wrote:
> 
> Keith Owens has such a script, and even posted it here a time or
> three. You can find it (and various other near scripts) at
> http://www.kernelnewbies.org/scripts/.

Good point!
Comparing both, there are some points in my favor though:
- Works for ppc as well, other platforms should be simple.
- Works for cross-compiling out of the box.
- More readable. :)

> As for making a Makefile target, nice idea, but probably 2.5 material. 

Probably, yes. I'll port it later today.

Jörn

-- 
"Security vulnerabilities are here to stay."
-- Scott Culp, Manager of the Microsoft Security Response Center, 2001
