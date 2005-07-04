Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVGDH6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVGDH6L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 03:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVGDH6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 03:58:11 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:13495 "EHLO
	ermintrude.int.immunix.com") by vger.kernel.org with ESMTP
	id S261554AbVGDHtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 03:49:16 -0400
Date: Mon, 4 Jul 2005 00:44:49 -0700
From: Tony Jones <tonyj@suse.de>
To: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Steve Beattie <smb@wirex.com>,
       Linux LSM list <linux-security-module@wirex.com>
Subject: Re: [PATCH 3/3] Use conditional
Message-ID: <20050704074449.GA12963@immunix.com>
References: <20050703154405.GE11093@tpkurt.garloff.de> <20050703190007.GA30292@immunix.com> <20050704065902.GO11093@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050704065902.GO11093@tpkurt.garloff.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2005 at 08:59:02AM +0200, Kurt Garloff wrote:

> > The topic of replacing dummy (with capability) was discussed there
> > last week, in the context of stacker, but a common solution for both
> > cases would be needed.
> 
> Both cases?

CONFIG_SECURITY_STACKER and !CONFIG_SECURITY_STACKER ;-)

http://mail.wirex.com/pipermail/linux-security-module/2005-June/6200.html

I was assuming (bad of me I know) that Serge's patch would nail both cases
with one stone.

Tony
