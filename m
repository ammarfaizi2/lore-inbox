Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbTDXD1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 23:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264345AbTDXD1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 23:27:10 -0400
Received: from litaipig.ucr.edu ([138.23.89.48]:32692 "EHLO
	mail-infomine.ucr.edu") by vger.kernel.org with ESMTP
	id S264304AbTDXD1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 23:27:08 -0400
Date: Wed, 23 Apr 2003 20:39:13 -0700
To: Steven Cole <elenstev@mesatop.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: How did the Spelling Police miss this one?
Message-ID: <20030424033913.GA32423@mail-infomine.ucr.edu>
References: <200304230936_MC3-1-35AA-864B@compuserve.com> <1051109635.29423.20.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051109635.29423.20.camel@spc9.esa.lanl.gov>
User-Agent: Mutt/1.3.28i
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
X-BeenThere: crackmonkey@crackmonkey.org
From: ruschein@mail-infomine.ucr.edu (Johannes Ruscheinski)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Steven Cole:
>... 
> The fix.canon script used was this:
> 
> #!/bin/sh
> find . -name "*" | xargs grep -l cannonicalize | awk '{print "ex - ",$1," -c \"%s/cannonicalize/canonicalize/g|x\""}' | sh
> ...
Hi Steve,

As far as I know there is no such words as "canonicalize" in the English
language.  The proper word seems to be "canonize".  Since I'm not a native
speaker please take my comment with a grain of salt.
-- 
Johannes
--
Dr. Johannes Ruscheinski
EMail:    ruschein_AT_infomine.ucr.edu ***          Linux                  ***
Location: science library, room G40    *** The Choice Of A GNU Generation! ***
Phone:    (XXX) YYY-ZZZZ

"Perennial nuisance Charlton Heston pops up to declare that there are "too
 many people on the Earth as it is" and one realizes instantly that as
 president of the NRA, he is doing his best to correct that."
               -- Tom Shales, The Washington Post
