Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWDRBpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWDRBpP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 21:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWDRBpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 21:45:15 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:62950 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932100AbWDRBpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 21:45:13 -0400
To: Christoph Hellwig <hch@infradead.org>
cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks 
In-reply-to: Your message of Mon, 17 Apr 2006 23:55:25 BST.
             <20060417225525.GA17463@infradead.org> 
Date: Mon, 17 Apr 2006 18:44:51 -0700
Message-Id: <E1FVfGt-0003Wy-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Apr 2006 23:55:25 BST, Christoph Hellwig wrote:
> On Mon, Apr 17, 2006 at 03:15:29PM -0700, Gerrit Huizenga wrote:
> > configure correctly that most of them disable it.  In theory, LSM +
> > something like AppArmour provides a much simpler security model for
> 
> apparmor falls into the findamentally broken category above, so it's
> totally uninteresting except as marketing candy for the big red company.

Is there a pointer to why it is fundamentally broken?  I haven't seen
such comments before but it may be that I've been hanging out on the
wrong lists or spending too much time inhaling air at 30,000 feet.

gerrit
