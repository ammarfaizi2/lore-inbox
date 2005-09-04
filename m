Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVIDWDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVIDWDQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 18:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVIDWDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 18:03:16 -0400
Received: from cavan.codon.org.uk ([217.147.81.22]:35045 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S932091AbVIDWDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 18:03:15 -0400
Date: Sun, 4 Sep 2005 23:02:01 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       76306.1226@compuserve.com, linux-kernel@vger.kernel.org
Subject: Re: Brand-new notebook useless with Linux...
Message-ID: <20050904220201.GA27033@srcf.ucam.org>
References: <200509031859_MC3-1-A720-F705@compuserve.com> <E1EBje3-0002GW-00@chiark.greenend.org.uk> <20050904142530.4b906fef.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050904142530.4b906fef.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 02:25:30PM -0700, Andrew Morton wrote:
> Matthew Garrett <mgarrett@chiark.greenend.org.uk> wrote:
> >
> >  > SD/MMC
> > 
> >  Ditto.
> > 
> 
> There are Secure Digital drivers in -mm.  I'm sure Pierre would like a
> tester..

Not for the TI part, as far as I know. The only specs available are for 
the PCI register space and the firmware loader interface - there's 
nothing on how to actually drive the device.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
