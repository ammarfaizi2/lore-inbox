Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422798AbWJaH7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422798AbWJaH7V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422913AbWJaH7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:59:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33930 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422798AbWJaH7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:59:19 -0500
Date: Mon, 30 Oct 2006 23:58:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <greg@kroah.com>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: 2.6.19-rc3-mm1 - udev doesn't work (was: ATI SATA controller
 not detected)
Message-Id: <20061030235850.cb3a40ed.akpm@osdl.org>
In-Reply-To: <200610310848.02739.rjw@sisk.pl>
References: <20061029160002.29bb2ea1.akpm@osdl.org>
	<200610310829.31554.rjw@sisk.pl>
	<20061030234008.51da7d9a.akpm@osdl.org>
	<200610310848.02739.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006 08:48:01 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > > It's one of these:
> > > 
> > > git-acpi.patch
> > > git-acpi-fixup.patch
> > > git-acpi-more-build-fixes.patch
> > > 
> > 
> > You might need to resend the original report so the acpi guys can see it.
> 
> Okay, I will.

Thanks.

> > Meanwhile, I'll have to drop the acpi tree.
> 
> Well, I'd prefer to find the offending commit within the tree, as the majority
> of changes look pretty innocent.  Are the commits available somewhere as
> individual patches?

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git#test

I've not had much success persuading git to emit a series of applyable
patches.

