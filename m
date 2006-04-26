Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWDZDmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWDZDmg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 23:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWDZDmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 23:42:35 -0400
Received: from web36607.mail.mud.yahoo.com ([209.191.85.24]:47243 "HELO
	web36607.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932254AbWDZDmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 23:42:06 -0400
Message-ID: <20060426034205.52426.qmail@web36607.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Tue, 25 Apr 2006 20:42:05 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: jmorris@namei.org, sds@tycho.nsa.gov, tytso@mit.edu,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20060425092141.d0151f66.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- "Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> use that internet thing, e.g., www.dict.org, and
> look at "conflate".

OK. I am not conflating the policy issues and the
mechanism issue of SELinux. The mechanisms of SELinux
lead to the policy issues. A complete set of policies
for an SELinux system require an unreasonable number
of rules. This violates the Third item of the TCB
principle, which is the the TCB must be small enough
to analyse. The mechanisms are pointless without the
rules.

Conflating my forehead!


Casey Schaufler
casey@schaufler-ca.com
