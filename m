Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWHaVML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWHaVML (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 17:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWHaVML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 17:12:11 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:46565 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751253AbWHaVMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 17:12:09 -0400
Subject: Re: [RFC] Simple userspace interface for PCI drivers
From: Lee Revell <rlrevell@joe-job.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1157057934.24286.3.camel@bip.parateam.prv>
References: <20060830062338.GA10285@kroah.com>
	 <1157013027.7566.515.camel@capoeira>  <1157056749.4386.137.camel@mindpipe>
	 <1157057934.24286.3.camel@bip.parateam.prv>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 17:12:13 -0400
Message-Id: <1157058734.4386.142.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 22:58 +0200, Xavier Bestel wrote:
> Precisely. How do you know the bugreport you received isn't caused by
> some weird binary userspace driver hosing the PCI bus ? 

Can't X, or any application that access hardware directly by
mmaping /dev/mem, do this now?

Lee

