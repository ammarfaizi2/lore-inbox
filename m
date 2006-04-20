Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWDTQ1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWDTQ1P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWDTQ1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:27:15 -0400
Received: from gate.in-addr.de ([212.8.193.158]:3971 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1751123AbWDTQ1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:27:14 -0400
Date: Thu, 20 Apr 2006 18:27:50 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Stephen Smalley <sds@tycho.nsa.gov>, Crispin Cowan <crispin@novell.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Tony Jones <tonyj@suse.de>,
       linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 4/11] security: AppArmor - Core access controls
Message-ID: <20060420162750.GF5658@marowsky-bree.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com> <1145470230.3085.84.camel@laptopd505.fenrus.org> <44468817.5060106@novell.com> <1145536393.3313.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145536393.3313.26.camel@moss-spartans.epoch.ncsc.mil>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-04-20T08:33:13, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > If you are a confined process, then you don't get to mount things, for
> > this reason, among others.
> Which is an example of the brokenness of the security model - its
> fragileness in the face of manipulation of the file tree leads to
> inflexibility.

Now, now. Not every _limitation_ translates to _brokenness_. Some of
them are simply that - limitations. If you no like, you no run that
particular solution.



-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

