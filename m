Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268099AbTBWJq4>; Sun, 23 Feb 2003 04:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268109AbTBWJqC>; Sun, 23 Feb 2003 04:46:02 -0500
Received: from Mix-Lyon-107-1-150.abo.wanadoo.fr ([193.249.22.150]:7303 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S268116AbTBWJpX>;
	Sun, 23 Feb 2003 04:45:23 -0500
Subject: Re: ethernet-ATM-Router freezing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030222130704.GB25040@torres.ka0.zugschlus.de>
References: <20030222084958.GC23827@torres.ka0.zugschlus.de>
	 <1045914526.12534.153.camel@zion.wanadoo.fr>
	 <20030222130704.GB25040@torres.ka0.zugschlus.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045994345.12533.168.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 23 Feb 2003 10:59:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-22 at 14:07, Marc Haber wrote:
> On Sat, Feb 22, 2003 at 12:48:46PM +0100, Benjamin Herrenschmidt wrote:
> > Your reasoning is wrong. It can well be a HW failure, those can be
> > load related in various way (memory failure happening when memory
> > is actually used, thermal failure happening on CPU load, etc...)
> > 
> > If the exact same setup worked for a while with same/similar loads
> > and suddenly started to fail, there are great chances it's actually
> > HW failure (possibly RAM).
> 
> So you think that we have had two machines going bad on us with the
> same kind of failure within just a few days?

Sorry, my fault, I mis-read your post and though only one of the
boxes was freezing.

Ben.
 
