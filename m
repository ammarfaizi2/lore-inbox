Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTJKCZQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 22:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbTJKCZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 22:25:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:38297 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263212AbTJKCZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 22:25:13 -0400
Date: Fri, 10 Oct 2003 19:23:36 -0700
From: Greg KH <greg@kroah.com>
To: Uncle Jens <kernel@millcreeksys.com>
Cc: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>,
       "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: [2.7 "thoughts"] V0.3
Message-ID: <20031011022336.GC19749@kroah.com>
References: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be> <1065820650.3f8721ea4162b@secure.millcreeksys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065820650.3f8721ea4162b@secure.millcreeksys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 03:17:30PM -0600, Uncle Jens wrote:
> What about some type of kernel-based-DRM, where only properly(trusted) signed
> binaries can be executed?

Already done for 2.6:
	http://sourceforge.net/projects/disec/

Grab the digsig package.

thanks,

greg k-h
