Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTIWUYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 16:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbTIWUYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 16:24:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:34701 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263394AbTIWUYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 16:24:09 -0400
Date: Tue, 23 Sep 2003 13:24:01 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Chris Wright <chrisw@osdl.org>, David Yu Chen <dychen@stanford.edu>,
       linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030923132401.J20572@osdlab.pdx.osdl.net>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU> <20030923131430.F20572@osdlab.pdx.osdl.net> <20030923202132.GA23796@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030923202132.GA23796@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Tue, Sep 23, 2003 at 01:21:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jean Tourrilhes (jt@bougret.hpl.hp.com) wrote:
> 
> 	This is simpler and more efficient ;-)

Yes, I agree, your patch is better.

-thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
