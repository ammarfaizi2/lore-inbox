Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318295AbSIFJ3i>; Fri, 6 Sep 2002 05:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318428AbSIFJ3i>; Fri, 6 Sep 2002 05:29:38 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:29146 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S318295AbSIFJ3g>; Fri, 6 Sep 2002 05:29:36 -0400
Date: Fri, 6 Sep 2002 10:49:22 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Greg Stark <gsstark@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need a URL for PPPoE by Michal Ostrowski
Message-ID: <20020906104922.Q781@nightmaster.csn.tu-chemnitz.de>
References: <87vg5kmad2.fsf@stark.dyndns.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <87vg5kmad2.fsf@stark.dyndns.tv>; from gsstark@mit.edu on Thu, Sep 05, 2002 at 04:48:09PM -0400
X-Spam-Score: -3.4 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *17nFVG-0000U1-00*iybbKuM3vZQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 04:48:09PM -0400, Greg Stark wrote:
> In June someone inquired about the Ostrowski's pppoe patch for pppd and was
> pointed to the ppp cvs archive at samba. However it seems the cvs archive
> there only has a roaring-penguin pppoe module, not the native kernel
> implementation.
> 
> What happened to the cleaner kernel implementation that didn't require extra
> user-space packet filters?

The roaring-penguin solution can use the in-kernel module, if
requested.

Mr. Ostrowski isn't maintaining his patch anymore, it seems.

The pppd got the plugin-architecture, as requested but didn't
adapt the pppoe module from Mr. Ostrowksi.

Maybe he himself or the PPP maintainer could elaborate, if they
read the message.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
