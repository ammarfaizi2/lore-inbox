Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWHIMce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWHIMce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWHIMcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:32:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42190 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750717AbWHIMcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:32:32 -0400
Subject: Re: [PATCH 03/14] V4L/DVB (4371b): Fix V4L1 dependencies at
	drivers under sound/oss and sound/pci
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
In-Reply-To: <1155074040.26338.115.camel@mindpipe>
References: <20060808210151.PS78629800000@infradead.org>
	 <20060808210653.PS04143800003@infradead.org>
	 <1155074040.26338.115.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 09 Aug 2006 09:32:06 -0300
Message-Id: <1155126726.13439.53.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Ter, 2006-08-08 às 17:54 -0400, Lee Revell escreveu:
> On Tue, 2006-08-08 at 18:06 -0300, mchehab@infradead.org wrote:
> > From: Mauro Carvalho Chehab <mchehab@infradead.org>
> >  	  For more information on this driver and the degree of support for
> >  	  the different card models please check:
> >  
> > -	        <http://sourceforge.net/projects/emu10k1/>
> > +		<http://sourceforge.net/projects/emu10k1/>
> 
> This seems to contain a ton of unrelated whitespace changes.
Sorry for that.

We have a zero tolerancy for bad whitespacing for the stuff under
drivers/media, so, I have a script that do a cleanup on whitespaces for
the files I touch, to avoid a propagation of whitespaces.

I didn't realized the script runned against sound/oss, fixed all those
bad whitespacing stuff there.

> Lee
> 
Cheers, 
Mauro.

