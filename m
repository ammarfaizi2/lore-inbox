Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267099AbSLKKDH>; Wed, 11 Dec 2002 05:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267101AbSLKKDH>; Wed, 11 Dec 2002 05:03:07 -0500
Received: from poup.poupinou.org ([195.101.94.96]:17452 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S267099AbSLKKDG>; Wed, 11 Dec 2002 05:03:06 -0500
Date: Wed, 11 Dec 2002 11:07:18 +0100
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "'Ducrot Bruno'" <poup@poupinou.org>,
       Ducrot Bruno <ducrot@poupinou.org>, Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: [2.5.50, ACPI] link error
Message-ID: <20021211100718.GB29390@poup.poupinou.org>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A581@orsmsx119.jf.intel.com> <1039481341.12046.21.camel@irongate.swansea.linux.org.uk> <20021210204031.GF20049@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021210204031.GF20049@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 09:40:31PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > I concur with your pros and cons. This makes me think that if S4BIOS support
> > > ever gets added, it should get added to 2.4 only.
> 
> And S4BIOS will never get added to 2.4 since it needs driver model
> :-(.

Well, it worked for me with 2.4 with 'basic' pm_send_xxx

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
