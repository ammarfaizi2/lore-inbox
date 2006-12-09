Return-Path: <linux-kernel-owner+w=401wt.eu-S1759825AbWLIXqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759825AbWLIXqI (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 18:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759848AbWLIXqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 18:46:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:55917 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759825AbWLIXqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 18:46:05 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.19 file content corruption on ext3
From: Mike Galbraith <efault@gmx.de>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061208164206.GA1125@torres.l21.ma.zugschlus.de>
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de>
	 <4578465D.7030104@cfl.rr.com>
	 <1165541892.1063.0.camel@sebastian.intellilink.co.jp>
	 <20061208164206.GA1125@torres.l21.ma.zugschlus.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 10 Dec 2006 00:46:01 +0100
Message-Id: <1165707961.4926.21.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-08 at 17:42 +0100, Marc Haber wrote:
> On Fri, Dec 08, 2006 at 10:38:12AM +0900, Fernando Luis Vázquez Cao wrote:
> > Does the patch below help?
> > 
> > http://marc.theaimsgroup.com/?l=linux-ext4&m=116483980823714&w=4
> 
> No, pkgcache.bin still getting corrupted within two hours of using
> 2.6.19.
> 
> Greetings
> Marc, back to 2.6.18.3 for the time being

Hi,

I've missed most of this thread, but have cause to be interested.  Do
you have a generic recipe for reproducing file corruption?  I seem to be
(read pretty darn sure, modulus hw (wish) vs sw testing methods...)
experiencing memory corruption problems with 2.6.19, and am interested
in anything that might be related (trigger!).

	-Mike

