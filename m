Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTEUXOP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 19:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTEUXOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 19:14:15 -0400
Received: from 213-97-199-90.uc.nombres.ttd.es ([213.97.199.90]:32955 "HELO
	fargo") by vger.kernel.org with SMTP id S262323AbTEUXOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 19:14:14 -0400
Date: Thu, 22 May 2003 01:32:20 +0200
From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: Hugo Mills <hugo-lkml@carfax.org.uk>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: e100 driver
Message-ID: <20030521233220.GA20622@fargo>
Mail-Followup-To: "Feldman, Scott" <scott.feldman@intel.com>,
	Hugo Mills <hugo-lkml@carfax.org.uk>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <C6F5CF431189FA4CBAEC9E7DD5441E010107D724@orsmsx402.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E010107D724@orsmsx402.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

> > I reloaded again the e100 module with this parameter. Let's 
> > see how it performs. Thanks for the advice ;)
> > 
> > I'll let you know if checksum errors doesn't show anymore.
> 
> There are several new reports of this problem, so we're trying to repro now...

Indeed disabling hardware receive hecksums made the problem go away, it's been
more that a day with no errors in my logs. If you want to know more about my
hardware/software configuration, let me know.

Thanks,
 
-- 
David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra
