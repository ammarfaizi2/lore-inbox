Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270271AbRHMQ2x>; Mon, 13 Aug 2001 12:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270295AbRHMQ2n>; Mon, 13 Aug 2001 12:28:43 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:6030 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S270271AbRHMQ2c>; Mon, 13 Aug 2001 12:28:32 -0400
Message-ID: <3B78002C.BA66F1E@vnet.ibm.com>
Date: Mon, 13 Aug 2001 16:28:28 +0000
From: Tom Gall <tom_gall@vnet.ibm.com>
Reply-To: tom_gall@vnet.ibm.com
Organization: IBM
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: scole@lanl.gov
CC: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, esr@thyrsus.com
Subject: Re: ppc64 submission
In-Reply-To: <3B77F5CF.5C3CF66D@vnet.ibm.com> <0108131028100D.30719@spc2.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> 
> Just one comment. I looked at this, and the following config options are
> added, but don't have Configure.help entries, so this is a "heads-up" that
> help texts for the following may eventually be needed.
> 
> CONFIG_ISTAR
> CONFIG_KDB
> CONFIG_KDB_OFF
> CONFIG_MOTOROLA_HOTSWAP
> CONFIG_MSCHUNKS
> CONFIG_PPCDBG
> CONFIG_PPC_ISERIES
> 
> Thanks in advance,
> Steven

Hi Steve,

  Thanks much for the catch. I knew there were a few we needed to get added.
I'll post a patch for these in the next day or so.

  Regards,

  Tom
  
-- 
Tom Gall - PPC64 Maintainer      "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc
