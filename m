Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318065AbSIAA0x>; Sat, 31 Aug 2002 20:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSIAA0x>; Sat, 31 Aug 2002 20:26:53 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:25078 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S318065AbSIAA0w>; Sat, 31 Aug 2002 20:26:52 -0400
Date: Sat, 31 Aug 2002 17:26:56 -0700
From: Chris Wright <chris@wirex.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Greg KH <greg@kroah.com>, Gabor Kerenyi <wom@tateyama.hu>,
       linux-kernel@vger.kernel.org, Chris Wright <chris@wirex.com>
Subject: Re: extended file permissions based on LSM
Message-ID: <20020831172656.E11165@figure1.int.wirex.com>
Mail-Followup-To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	Greg KH <greg@kroah.com>, Gabor Kerenyi <wom@tateyama.hu>,
	linux-kernel@vger.kernel.org, Chris Wright <chris@wirex.com>
References: <200208310616.04709.wom@tateyama.hu> <20020831052114.GA12082@kroah.com> <20020831095747.A781@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020831095747.A781@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Sat, Aug 31, 2002 at 09:57:47AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Oeser (ingo.oeser@informatik.tu-chemnitz.de) wrote:
> 
> So this is a correctly pointed out design weakness: The way the
> user took to reach the inode cannot be taken into account.

Yes, this is known, and there are anticipated VFS changes to remedy
this.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
