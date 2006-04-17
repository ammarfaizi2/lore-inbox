Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWDQWUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWDQWUx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 18:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWDQWUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 18:20:53 -0400
Received: from over.ny.us.ibm.com ([32.97.182.150]:28066 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP id S1751349AbWDQWUv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 18:20:51 -0400
Date: Mon, 17 Apr 2006 14:47:59 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net,
       David Safford <safford@watson.ibm.com>
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060417194759.GD18990@sergelap.austin.ibm.com>
References: <20060417180231.71328.qmail@web36606.mail.mud.yahoo.com> <1145297742.8542.206.camel@moss-spartans.epoch.ncsc.mil> <20060417192634.GB18990@sergelap.austin.ibm.com> <Pine.LNX.4.64.0604171528340.17923@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604171528340.17923@d.namei>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Morris (jmorris@namei.org):
> On Mon, 17 Apr 2006, Serge E. Hallyn wrote:
> 
> > Hopefully a new version of evm+slim+ima will be ready for distribution
> > soon.
> 
> Why are you still trying to introduce yet another access control model 
> into the kernel, when SELinux is already there?

Well actually I'm really not much involved.

> Last I recall on this issue, we asked if you could look at providing 
> integrity measurement as a distinct API, and integrity control as either 
> integrated with SELinux or a distinct component which SELinux could use.

And those are what I believe the next patchset will provide.

-serge
