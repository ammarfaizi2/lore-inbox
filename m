Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269325AbUICHNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269325AbUICHNj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269311AbUICHNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:13:39 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:43396 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S269295AbUICHNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:13:35 -0400
Date: Fri, 3 Sep 2004 03:13:35 -0400
To: linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040903071335.GB16619@delft.aura.cs.cmu.edu>
Mail-Followup-To: linux-fsdevel@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <200409022319.i82NJlTN025039@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409022319.i82NJlTN025039@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.6+20040803i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 07:19:47PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 02 Sep 2004 22:38:54 +0200, Frank van Maarseveen said:
> > 	cd /dev/cdrom
> > 	ls
> 
> And the CD in the drive at the moment is AC/DC "Back in Black".  What
> should this produce as output?

Hehe, cdfs already figured that one out. Ofcourse you show the
individual tracks as .wav files.

Jan
