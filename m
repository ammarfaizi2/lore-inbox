Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbUKDWru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbUKDWru (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbUKDWrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:47:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:64484 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262480AbUKDWps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:45:48 -0500
Date: Thu, 4 Nov 2004 14:45:47 -0800
From: Chris Wright <chrisw@osdl.org>
To: Serge Hallyn <serue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] [5/6] LSM Stacking: SELinux LSM stacking support
Message-ID: <20041104144547.B2357@build.pdx.osdl.net>
References: <1099609471.2096.10.camel@serge.austin.ibm.com> <1099609866.2096.23.camel@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1099609866.2096.23.camel@serge.austin.ibm.com>; from serue@us.ibm.com on Thu, Nov 04, 2004 at 05:11:06PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge Hallyn (serue@us.ibm.com) wrote:
> This patch adds stacking support to the SELinux LSM.

Please Cc: Stephen Smalley and James Morris on this one.  I'm sure
they'd like to look at the impact as well.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
