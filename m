Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWDZMK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWDZMK6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 08:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWDZMK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 08:10:58 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:63714 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932410AbWDZMK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 08:10:57 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, jmorris@namei.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20060426034205.52426.qmail@web36607.mail.mud.yahoo.com>
References: <20060426034205.52426.qmail@web36607.mail.mud.yahoo.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 26 Apr 2006 08:15:25 -0400
Message-Id: <1146053725.28745.50.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 20:42 -0700, Casey Schaufler wrote:
> 
> --- "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> 
> > use that internet thing, e.g., www.dict.org, and
> > look at "conflate".
> 
> OK. I am not conflating the policy issues and the
> mechanism issue of SELinux. The mechanisms of SELinux
> lead to the policy issues. A complete set of policies
> for an SELinux system require an unreasonable number
> of rules. This violates the Third item of the TCB
> principle, which is the the TCB must be small enough
> to analyse. The mechanisms are pointless without the
> rules.
> 
> Conflating my forehead!

The policy is analyzable, and there are tools (apol and slat) that do
precisely that.  Including information flow analysis and invariant
checking.  What's your problem, again?

-- 
Stephen Smalley
National Security Agency

