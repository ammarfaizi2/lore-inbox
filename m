Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265012AbTAETpP>; Sun, 5 Jan 2003 14:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbTAETpP>; Sun, 5 Jan 2003 14:45:15 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37507
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265012AbTAETpO>; Sun, 5 Jan 2003 14:45:14 -0500
Subject: Re: 2.5.54 problem with IDE ICH4 and aic7xxx
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030105194129.GA10718@ulima.unil.ch>
References: <20030105165441.GA8215@ulima.unil.ch>
	 <486950000.1041788147@aslan.scsiguy.com>
	 <20030105174245.GB8840@ulima.unil.ch>
	 <1041792558.14531.0.camel@irongate.swansea.linux.org.uk>
	 <20030105194129.GA10718@ulima.unil.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041799076.14531.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 05 Jan 2003 20:37:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-05 at 19:41, Gregoire Favre wrote:
> On Sun, Jan 05, 2003 at 06:49:19PM +0000, Alan Cox wrote:
> 
> > Please check 2.4.21pre2 - does that also have IDE delays ?
> 
> Just compiled and booted 2.4.21-pre2: no delays at all, in fact even
> with my video=matrox:1600x1200-16@75 I don't have the time to read the
> messages ;-)

Thanks - that eliminates the IDE layer at least

