Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbTDKSaH (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 14:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbTDKSaH (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 14:30:07 -0400
Received: from splat.lanl.gov ([128.165.17.254]:47012 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id S261246AbTDKSaG (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 14:30:06 -0400
Date: Fri, 11 Apr 2003 12:41:40 -0600
From: Eric Weigle <ehw@lanl.gov>
To: Nicholas Berry <nikberry@med.umich.edu>
Cc: john@grabjohn.com, freesoftwaredeveloper@web.de,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411184140.GT14040@lanl.gov>
References: <200304112003.08558.freesoftwaredeveloper@web.de> <se96cd49.002@mail-01.med.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <se96cd49.002@mail-01.med.umich.edu>
X-Eric-Conspiracy: There is no conspiracy
X-Editor: Vim, http://www.vim.org
X-GnuPG-fingerprint: 112E F8CA 12A9 771E DB10  6514 D4B0 D758 59EA 9C4F
X-GnuPG-key: http://public.lanl.gov/ehw/ehw.gpg.key
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [Puzzle]
> > Say the power supply had five 5.25" drive power connecters, how many 1
> > into 3 power cable splitters would you need to connect all 4000 disks?
>> 400 (hit me if this is wrong :)
> Hit hit hit.
> 
> Could be wrong, but I make it 1939.
> Nik
Uhm.. how? You start with 5, each 1-3 splitter takes one and provides 3,
net gain of 2, regardless of how it's wired. 5+2*x >= 4000 --> x>=1998.

-Eric

-- 
------------------------------------------------------------
        Eric H. Weigle -- http://public.lanl.gov/ehw/
"They that can give up essential liberty to obtain a little
temporary safety deserve neither" -- Benjamin Franklin
------------------------------------------------------------
