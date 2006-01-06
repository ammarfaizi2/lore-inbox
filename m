Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWAFVJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWAFVJi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWAFVJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:09:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45037 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932521AbWAFVJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:09:37 -0500
Date: Fri, 6 Jan 2006 16:09:34 -0500
From: Dave Jones <davej@redhat.com>
To: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux/ACPI mailing list moved
Message-ID: <20060106210934.GL4595@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
References: <200601060149.03494.len.brown@intel.com> <20060106095320.GA14213@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106095320.GA14213@titan.lahn.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 10:53:20AM +0100, Philipp Matthias Hahn wrote:
 > Hello!
 > 
 > From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
 > 
 > On Fri, Jan 06, 2006 at 01:49:02AM -0500, Len Brown wrote:
 > > Please note that acpi-devel@lists.sourceforge.net is defunct.
 > >
 > > The new list to use for Linux/ACPI topics is linux-acpi@vger.kernel.org
 > Signed-off-by: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
 > ---
 > ... translates to ...
 > 
 > --- linux-2.6.15/MAINTAINERS~	2006-01-02 11:22:54.000000000 +0100
 > +++ linux-2.6.15/MAINTAINERS	2006-01-06 10:47:23.000000000 +0100
 > @@ -182,7 +182,7 @@
 >  ACPI
 >  P:	Len Brown
 >  M:	len.brown@intel.com
 > -L:	acpi-devel@lists.sourceforge.net
 > +L:	linux-acpi@vger.kernel.org
 >  W:	http://acpi.sourceforge.net/
 >  T:	git kernel.org:/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git
 >  S:	Maintained

There's another one in Documentation/pm.txt that needs changing.

		Dave
