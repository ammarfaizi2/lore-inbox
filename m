Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266903AbTAIRSS>; Thu, 9 Jan 2003 12:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTAIRSS>; Thu, 9 Jan 2003 12:18:18 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:3470
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266903AbTAIRSR>; Thu, 9 Jan 2003 12:18:17 -0500
Subject: Re: [PATCH] PATCH: IPMI driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030109172229.GA27288@codemonkey.org.uk>
References: <200301090332.h093WML05981@hera.kernel.org>
	 <20030109164407.GA26195@codemonkey.org.uk>
	 <1042135594.27796.37.camel@irongate.swansea.linux.org.uk>
	 <20030109172229.GA27288@codemonkey.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042135971.27796.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 09 Jan 2003 18:12:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 17:22, Dave Jones wrote:
> On Thu, Jan 09, 2003 at 06:06:34PM +0000, Alan Cox wrote:
> 
>  > Arghhh I was told Linus accepted it, and my tree indexer found "IPMI" so
>  > decided it was present too. (Only the i2c definitions apparently).
> 
> Shouldn't cause any problems in 2.4 anyways should it ?
> After all, its 'just another driver'.
> 
>  > Oh well, it should be in 2.5
> 
> Added to the queue of bits from the 2.4 changesets list that I'm
> intending to push to Linus soon.

Pull the 2.5 port from openipmi.sourceforge.net  saves you doing the port
yourself. 

