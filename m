Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbTIXAS2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 20:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbTIXASO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 20:18:14 -0400
Received: from mail.kroah.org ([65.200.24.183]:19894 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261219AbTIXASJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 20:18:09 -0400
Date: Tue, 23 Sep 2003 17:17:28 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>
Cc: David Yu Chen <dychen@stanford.edu>, linux-kernel@vger.kernel.org,
       mc@cs.stanford.edu, vojtech@suse.cz
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030924001728.GI6435@kroah.com>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU> <20030923131350.D20572@osdlab.pdx.osdl.net> <20030923202554.GA5485@kroah.com> <20030923151456.A15254@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923151456.A15254@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 03:14:56PM -0700, Chris Wright wrote:
> * Greg KH (greg@kroah.com) wrote:
> > Don't know, Vojtech said he would fix these up already.  Try asking him
> > :)
> 
> I checked with Vojtech, he said the patch looked OK.  Can you apply?

Applied, thanks.

greg k-h

