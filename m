Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTLDKBV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 05:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTLDKBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 05:01:20 -0500
Received: from seconix.com ([213.193.144.104]:56517 "EHLO seconix.com")
	by vger.kernel.org with ESMTP id S262838AbTLDKBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 05:01:19 -0500
Subject: Re: [ACPI] Re: Tell user when ACPI is killing machine
From: Damien Sandras <damien.sandras@it-optics.com>
To: Pavel Machek <pavel@suse.cz>
Cc: "Yu, Luming" <luming.yu@intel.com>, Aaron Lehmann <aaronl@vitelus.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031204095454.GC6911@atrey.karlin.mff.cuni.cz>
References: <3ACA40606221794F80A5670F0AF15F8401720BFD@pdsmsx403.ccr.corp.intel.com>
	 <20031204095454.GC6911@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1070532076.1645.42.camel@golgoth01>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Dec 2003 11:01:16 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a similar problem since test10 and test11 (2.4.23 is ok, test9 is
ok too). ACPI reports bogus temperatures and powers the machine down.

If you have a patch that could fix that problem, I'm ready to try it and
report success or failure ;)

Le jeu 04/12/2003 à 10:54, Pavel Machek a écrit :
> Hi!
> 
> > >cpufreq is not connected to acpi thermal subsystem. Dominik has some
> > >patches to change that, IIRC.
> > Is it merged into ACPI ?
> 
> Not yet, IIRC. It is pretty big patch.
> 								Pavel
-- 
 _      Damien Sandras
(o-     
//\     It-Optics s.a.
v_/_    GnomeMeeting: http://www.gnomemeeting.org/
        FOSDEM 2004:  http://www.fosdem.org
        H.323 phone:  callto:ils.seconix.com/dsandras@seconix.com

