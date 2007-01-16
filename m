Return-Path: <linux-kernel-owner+w=401wt.eu-S1751972AbXAQAbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbXAQAbA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 19:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbXAQAbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 19:31:00 -0500
Received: from farad.aurel32.net ([82.232.2.251]:18569 "EHLO mail.aurel32.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972AbXAQAa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 19:30:59 -0500
X-Greylist: delayed 2908 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 19:30:59 EST
Date: Wed, 17 Jan 2007 00:42:35 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: IPv6 router advertisement broken on 2.6.20-rc5
Message-ID: <20070116234235.GA23405@amd64.aurel32.net>
Mail-Followup-To: Aurelien Jarno <aurelien@aurel32.net>,
	bert hubert <bert.hubert@netherlabs.nl>,
	linux-kernel@vger.kernel.org
References: <45AD46DD.7050408@aurel32.net> <20070116233053.GA667@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20070116233053.GA667@outpost.ds9a.nl>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 12:30:53AM +0100, bert hubert wrote:
> On Tue, Jan 16, 2007 at 10:42:53PM +0100, Aurelien Jarno wrote:
> 
> > I have just tried a 2.6.20-rc5 kernel (I previously used a 2.6.19 one),
> > and I have noticed that the IPv6 router advertisement functionality is
> 
> Can you check if rc1, rc2, rc3 etc do work?

Will do that, but probably not in a very short timeframe (in other words
next evening, in about 20 hours).

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
