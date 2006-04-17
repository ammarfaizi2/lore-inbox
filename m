Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWDQTfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWDQTfL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 15:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWDQTfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 15:35:11 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:39336 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750744AbWDQTfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 15:35:10 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
       James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <20060417192634.GB18990@sergelap.austin.ibm.com>
References: <20060417180231.71328.qmail@web36606.mail.mud.yahoo.com>
	 <1145297742.8542.206.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417192634.GB18990@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 17 Apr 2006 15:37:13 -0400
Message-Id: <1145302633.8542.233.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 14:26 -0500, Serge E. Hallyn wrote:
> Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > Then provide a counterexample.
> 
> Hopefully a new version of evm+slim+ima will be ready for distribution
> soon.

IIRC, upon their last submission (at which time they were severely
broken in design and implementation), it was demonstrated that they
didn't make sense as separate LSMs, and that their separation was
actually harmful to a correct and efficient implementation.

-- 
Stephen Smalley
National Security Agency

