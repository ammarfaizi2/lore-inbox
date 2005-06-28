Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVF1Vbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVF1Vbf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVF1Vbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:31:34 -0400
Received: from isilmar.linta.de ([213.239.214.66]:57275 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261302AbVF1V3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:29:06 -0400
Date: Tue, 28 Jun 2005 23:29:05 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Erik Slagter <erik@slagter.name>, venkatesh.pallipadi@intel.com,
       len.brown@intel.com
Cc: Andrew Haninger <ahaning@gmail.com>, Jim serio <jseriousenet@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: C2/C3 on SMP [Was: Re: 2.6.X not recognizing second CPU]
Message-ID: <20050628212905.GA31610@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Erik Slagter <erik@slagter.name>, venkatesh.pallipadi@intel.com,
	len.brown@intel.com, Andrew Haninger <ahaning@gmail.com>,
	Jim serio <jseriousenet@gmail.com>, linux-kernel@vger.kernel.org
References: <3642108305062711524e1e163@mail.gmail.com> <105c793f050627123583a70d0@mail.gmail.com> <3642108305062713487326b672@mail.gmail.com> <105c793f05062714022ad4359@mail.gmail.com> <20050627214249.GA29657@isilmar.linta.de> <1119958379.3969.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119958379.3969.9.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 01:32:59PM +0200, Erik Slagter wrote:
> On Mon, 2005-06-27 at 23:42 +0200, Dominik Brodowski wrote:
> > a) Power Management is available on SMP, though support for it is a bit less
> >    wide-spread than it is for UP
> 
> Still no C2/C3 handling :-(

Uh, wasn't there a small, nice patch implementing this in bk-acpi a few 
weeks ago?
*clicketyclick* Oh yes,
http://bugzilla.kernel.org/show_bug.cgi?id=4401
states it was merged into bk-acpi-test on 2005-04-22. However, I can't find
it in current -mm any more...

	Dominik
