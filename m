Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317733AbSFLQeh>; Wed, 12 Jun 2002 12:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317734AbSFLQeg>; Wed, 12 Jun 2002 12:34:36 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:18919 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S317733AbSFLQef>; Wed, 12 Jun 2002 12:34:35 -0400
Date: Wed, 12 Jun 2002 18:34:53 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: "Randy.Dunlap" <rddunlap@osdl.org>,
        Ravikiran G Thirumalai <kiran@in.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: question: i/o port 0x61 on x86 archs
In-Reply-To: <20020612180325.E22429@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.GSO.3.96.1020612183253.8068D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002, Ingo Oeser wrote:

> > Port 0x61 is the NMI status and control register.
> 
> So it should exist a '#define' for this somewhere. 
> 
> People who tend to disagree here, may try to use *.i files
> instead of *.c and *.h files next time.

 Feel free to submit a patch.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

