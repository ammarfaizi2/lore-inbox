Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272234AbRIKBIG>; Mon, 10 Sep 2001 21:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272241AbRIKBH4>; Mon, 10 Sep 2001 21:07:56 -0400
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:40716 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id <S272234AbRIKBHt>; Mon, 10 Sep 2001 21:07:49 -0400
Date: Tue, 11 Sep 2001 02:08:08 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: serial overruns
Message-ID: <20010911020808.B88440@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm getting input overruns on a serial console with rates from 9600-38400

The serial HOWTO suggests irqtune might be able to help with this problem (which
I really need to solve). Is there a 2.4 version available ? If not, would updating
irqtune and using it be likely to help ?

thanks
john

-- 
"Since when would the sizeof any kind of pointer be zero ? 
 Have you built a zero-bit CPU ?"
	- Jeffrey Turner
