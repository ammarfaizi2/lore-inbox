Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWDYEZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWDYEZt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 00:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWDYEZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 00:25:49 -0400
Received: from web36603.mail.mud.yahoo.com ([209.191.85.20]:36730 "HELO
	web36603.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750926AbWDYEZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 00:25:48 -0400
Message-ID: <20060425042542.53414.qmail@web36603.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Mon, 24 Apr 2006 21:25:42 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
To: Stephen Smalley <sds@tycho.nsa.gov>, "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <1145912876.14804.91.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Stephen Smalley <sds@tycho.nsa.gov> wrote:


> Seems like a strawman.  We aren't claiming that
> SELinux is perfect, and
> there is plenty of work ongoing on SELinux
> usability.  But a
> fundamentally unsound mechanism is more dangerous
> than one that is never
> enabled; at least in the latter case, one knows
> where one stands.  It is
> the illusory sense of security that accompanies
> path-based access
> control that is dangerous.

I suggest that this logic be applied to
the "strict policy", "targeted policy",
and "user written policy" presentations
of SELinux. You never know what the policy
might be.



Casey Schaufler
casey@schaufler-ca.com
