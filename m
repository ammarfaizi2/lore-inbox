Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314070AbSDKOQQ>; Thu, 11 Apr 2002 10:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314071AbSDKOQP>; Thu, 11 Apr 2002 10:16:15 -0400
Received: from sebula.traumatized.org ([193.121.72.130]:30085 "EHLO
	sparkie.is.traumatized.org") by vger.kernel.org with ESMTP
	id <S314070AbSDKOQO>; Thu, 11 Apr 2002 10:16:14 -0400
Date: Thu, 11 Apr 2002 16:08:38 +0200
From: Jurgen Philippaerts <jurgen@pophost.eunet.be>
To: linux-kernel@vger.kernel.org
Subject: Re: arch/sparc64/kernel/traps.c
Message-ID: <20020411140838.GE7545@sparkie.is.traumatized.org>
In-Reply-To: <20020409212000.GK9996@sparkie.is.traumatized.org> <200204110547.g3B5l3X08802@Port.imtp.ilyichevsk.odessa.ua> <20020411103444.GA7280@sparkie.is.traumatized.org> <200204111249.g3BCnnX10316@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i (Linux 2.4.19-pre5 sparc64)
X-Files: the truth is out there
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 03:00:14PM +0200, Denis Vlasenko wrote:
> 
> >it all looks like the new version to me
> 
> Double check that you built ksymoops against these libs, not older ones.
> Even if you deleted them, you may still be using old ksymoops binary!

i don't have an old ksymoops binary :) it just did not want to
compile until i removed the old binutils, and installed the new
version.

just to be sure, i removed the source dir for ksymoops, unpacked it
again, recompiled, and ran it from thre. same result.


i think i'll just let it rest, and give it another go next time i get
an oops :) so far my box seems to be running as i expect it to run,
so i won't worry too much about it.
unless one of the developers really needs it :)

best regards,
Jurgen.
