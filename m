Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWHaVSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWHaVSA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 17:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWHaVSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 17:18:00 -0400
Received: from smtp6.orange.fr ([193.252.22.25]:2236 "EHLO
	smtp-msa-out06.orange.fr") by vger.kernel.org with ESMTP
	id S932342AbWHaVSA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 17:18:00 -0400
X-ME-UUID: 20060831211759150.24CBE1C00293@mwinf0606.orange.fr
Subject: Re: [RFC] Simple userspace interface for PCI drivers
From: Xavier Bestel <xavier.bestel@free.fr>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1157058734.4386.142.camel@mindpipe>
References: <20060830062338.GA10285@kroah.com>
	 <1157013027.7566.515.camel@capoeira>  <1157056749.4386.137.camel@mindpipe>
	 <1157057934.24286.3.camel@bip.parateam.prv>
	 <1157058734.4386.142.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 31 Aug 2006 23:18:33 +0200
Message-Id: <1157059114.24286.7.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 31 août 2006 à 17:12 -0400, Lee Revell a écrit :
> On Thu, 2006-08-31 at 22:58 +0200, Xavier Bestel wrote:
> > Precisely. How do you know the bugreport you received isn't caused by
> > some weird binary userspace driver hosing the PCI bus ? 
> 
> Can't X, or any application that access hardware directly by
> mmaping /dev/mem, do this now?

Yes they can, but X's behavior is pretty well known by now :) and it's
open source.

	Xav

