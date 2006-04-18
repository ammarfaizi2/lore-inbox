Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWDRLzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWDRLzv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 07:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWDRLzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 07:55:51 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:52963 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932213AbWDRLzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 07:55:50 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <E1FVfGt-0003Wy-00@w-gerrit.beaverton.ibm.com>
References: <E1FVfGt-0003Wy-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 18 Apr 2006 07:59:47 -0400
Message-Id: <1145361587.16632.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 18:44 -0700, Gerrit Huizenga wrote:
> On Mon, 17 Apr 2006 23:55:25 BST, Christoph Hellwig wrote:
> > On Mon, Apr 17, 2006 at 03:15:29PM -0700, Gerrit Huizenga wrote:
> > > configure correctly that most of them disable it.  In theory, LSM +
> > > something like AppArmour provides a much simpler security model for
> > 
> > apparmor falls into the findamentally broken category above, so it's
> > totally uninteresting except as marketing candy for the big red company.
> 
> Is there a pointer to why it is fundamentally broken?  I haven't seen
> such comments before but it may be that I've been hanging out on the
> wrong lists or spending too much time inhaling air at 30,000 feet.

See the last para of the Useability discussion from the SELinux summit
minutes:
http://www.selinux-symposium.org/2006/summit.php
(re a proposal for pathname-based configuration in SELinux, and why it isn't a good idea)

-- 
Stephen Smalley
National Security Agency

