Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbVIUNwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbVIUNwy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 09:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbVIUNwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 09:52:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22674 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750930AbVIUNwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 09:52:54 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, len.brown@intel.com,
       Pierre Ossman <drzeus-list@drzeus.cx>, acpi-devel@lists.sourceforge.net,
       ncunningham@cyclades.com, Masoud Sharbiani <masouds@masoud.ir>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 21 Sep 2005 07:50:32 -0600
In-Reply-To: <20050921101855.GD25297@atrey.karlin.mff.cuni.cz> (Pavel
 Machek's message of "Wed, 21 Sep 2005 12:18:55 +0200")
Message-ID: <m1zmq6edhz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> I think you are not following the proper procedure. All the patches
> should go through akpm.

Ok.  I must have missed the most recent procedure change.

Anyway. Andrew has picked these patches up so all looks good.

Eric
