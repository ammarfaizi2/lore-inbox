Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313051AbSC0QVP>; Wed, 27 Mar 2002 11:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313049AbSC0QVH>; Wed, 27 Mar 2002 11:21:07 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:43170 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S313050AbSC0QU7>; Wed, 27 Mar 2002 11:20:59 -0500
Date: Wed, 27 Mar 2002 17:21:09 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] P4/Xeon Thermal LVT support
In-Reply-To: <Pine.LNX.4.44.0203271754040.8973-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.GSO.3.96.1020327171622.8602L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Zwane Mwaikambo wrote:

> Would f0 be ok? But i see its assigned for "future linux use"

 Well I see:

Vectors 0xf0-0xfa are free (reserved for future Linux use).

and your code definitely qualifies here. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

