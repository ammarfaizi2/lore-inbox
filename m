Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUC3WEb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUC3WCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:02:49 -0500
Received: from ns.suse.de ([195.135.220.2]:16785 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261425AbUC3WCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:02:17 -0500
Subject: Re: 2.6.5-rc3-mm1
From: Chris Mason <mason@suse.com>
To: Sid Boyce <sboyce@blueyonder.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4069ED67.5050302@blueyonder.co.uk>
References: <4069DC40.3070703@blueyonder.co.uk>
	 <1080681249.3547.51.camel@watt.suse.com>
	 <4069ED67.5050302@blueyonder.co.uk>
Content-Type: text/plain
Message-Id: <1080684268.3529.72.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 17:04:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-30 at 16:57, Sid Boyce wrote:
> Chris Mason wrote:
> 
> >On Tue, 2004-03-30 at 15:44, Sid Boyce wrote:
> >  
> >
> >>It builds fine on x86_64 but locks up solid at ----
> >>found reiserfs format "3.6" with standard journal
> >>Hard disk light permanently on - 2.6.5-rc2 vanilla is the last one to 
> >>boot fully, haven't tried 2.6.5-rc3 vanilla yet.
> >>    
> >>
> >
> >Have you tried booting with acpi=off?
> >
> With acpi=off, I get a string of messages

Try pci=noacpi

-chris


