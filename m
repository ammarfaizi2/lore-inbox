Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288352AbSACWeW>; Thu, 3 Jan 2002 17:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288350AbSACWeM>; Thu, 3 Jan 2002 17:34:12 -0500
Received: from pool-141-154-202-101.bos.east.verizon.net ([141.154.202.101]:18436
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S288336AbSACWd4>; Thu, 3 Jan 2002 17:33:56 -0500
To: Nathan Bryant <nbryant@allegientsystems.com>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Thomas Gschwind <tom@infosys.tuwien.ac.at>,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: i810_audio]
In-Reply-To: <3C3382CA.3000503@allegientsystems.com>
	<3C345493.5040800@evision-ventures.com>
	<20020103154718.C32419@infosys.tuwien.ac.at>
	<3C347A12.3070404@evision-ventures.com>
	<3C34B35A.7000309@allegientsystems.com>
From: Nick Papadonis <nick@coelacanth.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Date: 03 Jan 2002 17:33:50 -0500
In-Reply-To: <3C34B35A.7000309@allegientsystems.com> (Nathan Bryant's message of "Thu, 03 Jan 2002 14:39:06 -0500")
Message-ID: <m3ell76p4h.fsf@localhost.localdomain>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried the 0.13 driver yesterday.  It appears to work fine, but when
I insert my Orinoco WaveLan card they system locks up.  I reverted to
the i810 audio driver included in kernel v2.4.16 and this problem
isn't encountered.

Is there a conflict with the orinoco and orinoco_cs drivers from
kernel v2.4.16?

- Nick
