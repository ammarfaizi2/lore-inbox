Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbTIRBZu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 21:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbTIRBZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 21:25:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:56545 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262865AbTIRBZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 21:25:50 -0400
Date: Wed, 17 Sep 2003 18:25:43 -0700
From: Chris Wright <chrisw@osdl.org>
To: John R Moser <jmoser5@student.ccbc.cc.md.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Small security option
Message-ID: <20030917182543.A17202@osdlab.pdx.osdl.net>
References: <Pine.A32.3.91.1030917204729.33040A-200000@student.ccbc.cc.md.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.A32.3.91.1030917204729.33040A-200000@student.ccbc.cc.md.us>; from jmoser5@student.ccbc.cc.md.us on Wed, Sep 17, 2003 at 08:55:44PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John R Moser (jmoser5@student.ccbc.cc.md.us) wrote:
> Why wasn't this done in the first place anyway? 
> 
> Some sysadmins like to disable the other boot devices and password-protect
> the bios.  Good, but if the person can pass init=, you're screwed. 
> 
> Here's a small patch that does a very simple thing: Disables "init=" and
> using /bin/sh for init. That'll stop people from rooting the box from grub. 

If you have this access, you already own the box.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
