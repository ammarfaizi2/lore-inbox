Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264943AbTAER4j>; Sun, 5 Jan 2003 12:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264945AbTAER4j>; Sun, 5 Jan 2003 12:56:39 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29827
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264943AbTAER4i>; Sun, 5 Jan 2003 12:56:38 -0500
Subject: Re: 2.5.54 problem with IDE ICH4 and aic7xxx
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030105174245.GB8840@ulima.unil.ch>
References: <20030105165441.GA8215@ulima.unil.ch>
	 <486950000.1041788147@aslan.scsiguy.com>
	 <20030105174245.GB8840@ulima.unil.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041792558.14531.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 05 Jan 2003 18:49:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-05 at 17:42, Gregoire Favre wrote:
> On Sun, Jan 05, 2003 at 10:35:47AM -0700, Justin T. Gibbs wrote:
> > > Under 2.4.20 it boots perfectly...
> > > What I found really strange is the time my IDE take to boot. More than
> > > five minutes for thoses lines :
> > 
> > It's not clear from your report exactly where that delay is occurring.
> 
> Oups, sorry ;-)
> The delay is in the IDE process, all lines take age to appear...

Please check 2.4.21pre2 - does that also have IDE delays ?

