Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270432AbTGSA37 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 20:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270448AbTGSA37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 20:29:59 -0400
Received: from mail.skjellin.no ([80.239.42.67]:38103 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S270432AbTGSA35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 20:29:57 -0400
Subject: Re: libata driver update posted
From: Andre Tomt <andre@tomt.net>
To: azarah@gentoo.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Catalin BOIE <util@deuroconsult.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <1058574616.1834.24.camel@nosferatu.lan>
References: <3F1711C8.6040207@pobox.com>
	 <Pine.LNX.4.53.0307180924020.19703@hosting.rdsbv.ro>
	 <3F17F28C.9050105@pobox.com>
	 <1058542771.13515.1599.camel@workshop.saharacpt.lan>
	 <20030718154322.GB27152@gtf.org>  <1058574616.1834.24.camel@nosferatu.lan>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1058575500.3407.103.camel@slurv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 19 Jul 2003 02:45:01 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On l?, 2003-07-19 at 02:30, Martin Schlemmer wrote:
> On Fri, 2003-07-18 at 17:43, Jeff Garzik wrote:
> 
> > > How is performance compared to the default driver for the ICH5 SATA ?
> > 
> > I haven't done any comparisons because the "default driver" just flat
> > out doesn't work for me.
> > 
> > However, if performance is lower, then I consider that a bug.
> > 
> 
> Question if you do not mind me being a tad lazy - in ZA SCSI is damn
> expensive, so not much experience ... is there something like hdparm -t
> to check throughput ?

hdparm -t works on scsi too. and md, and, well, any block device?

:-)

-- 
Cheers,
André Tomt
andre@tomt.net

