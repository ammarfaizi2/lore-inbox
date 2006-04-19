Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWDSPni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWDSPni (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWDSPni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:43:38 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:55479 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750921AbWDSPng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:43:36 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Safford <safford@watson.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, James Morris <jmorris@namei.org>,
       casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1145458322.2377.12.camel@localhost.localdomain>
References: <20060417180231.71328.qmail@web36606.mail.mud.yahoo.com>
	 <1145297742.8542.206.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417192634.GB18990@sergelap.austin.ibm.com>
	 <Pine.LNX.4.64.0604171528340.17923@d.namei>
	 <20060417194759.GD18990@sergelap.austin.ibm.com>
	 <1145304146.8542.251.camel@moss-spartans.epoch.ncsc.mil>
	 <1145458322.2377.12.camel@localhost.localdomain>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 19 Apr 2006 11:47:40 -0400
Message-Id: <1145461660.24289.131.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 10:52 -0400, David Safford wrote:
> I seem to recall a number of people arguing for the low water-mark 
> integrity policy as one which provides a simple, user friendly 
> policy, one which has been demonstrated and tested not only by
> SLIM, but also with predecessors, such as LOMAC. 

BTW, since you point to LOMAC as evidence, can you point to an actual
user community that uses LOMAC?  It has been in the FreeBSD tree for
some time, so one might expect to find some users by now.

-- 
Stephen Smalley
National Security Agency

