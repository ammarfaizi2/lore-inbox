Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbTDXEPV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbTDXEPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:15:21 -0400
Received: from miranda.zianet.com ([216.234.192.169]:45828 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S264379AbTDXEPU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:15:20 -0400
Subject: Re: How did the Spelling Police miss this one?
From: Steven Cole <elenstev@mesatop.com>
To: Johannes Ruscheinski <ruschein@mail-infomine.ucr.edu>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20030424033913.GA32423@mail-infomine.ucr.edu>
References: <200304230936_MC3-1-35AA-864B@compuserve.com>
	 <1051109635.29423.20.camel@spc9.esa.lanl.gov>
	 <20030424033913.GA32423@mail-infomine.ucr.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1051158383.22271.123.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 23 Apr 2003 22:26:23 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 21:39, Johannes Ruscheinski wrote:
> Also sprach Steven Cole:
> >... 
> > The fix.canon script used was this:
> > 
> > #!/bin/sh
> > find . -name "*" | xargs grep -l cannonicalize | awk '{print "ex - ",$1," -c \"%s/cannonicalize/canonicalize/g|x\""}' | sh
> > ...
> Hi Steve,
> 
> As far as I know there is no such words as "canonicalize" in the English
> language.  The proper word seems to be "canonize".  Since I'm not a native
> speaker please take my comment with a grain of salt.

Strictly speaking, you are probably right.  According to this:
http://www.m-w.com/cgi-bin/dictionary?book=Dictionary&va=canonize
sense #2 would qualify "canonize".  I took the position that the only
person who could "canonize" anything is an elderly Polish fellow living
in Rome. But I've been wrong before.

The tortured variant "canonicalize" has seen enough usage to warrant
this related entry here:
http://whatis.techtarget.com/definition/0%2c%2csid9_gci841392%2c00.html

As far as "no such words" go, a descriptive grammar is generally more
useful for human languages than a prescriptive grammar.  Healthy human
languages allow for growth.  See Tao Te Ching 76. (late night rambling)

Steven "verbalizing in his native language, where nouns and adjectives can be verbed" Cole





