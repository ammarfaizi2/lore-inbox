Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVAYJn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVAYJn7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 04:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVAYJn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 04:43:59 -0500
Received: from orb.pobox.com ([207.8.226.5]:19848 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261869AbVAYJn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 04:43:58 -0500
Date: Tue, 25 Jan 2005 01:43:50 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
       Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 4/29] x86-i8259-shutdown
Message-ID: <20050125094350.GA6372@ip68-4-98-123.oc.oc.cox.net>
References: <x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com> <1106623970.2399.205.camel@d845pe> <20050125035930.GG13394@redhat.com> <m1sm4phpor.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1sm4phpor.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 01:35:00AM -0700, Eric W. Biederman wrote:
> So I will ask again, as I did when Andrew first pointed this in my
> direction.  What code path in the kernel could possibly care if we
> disable the i8259 after we have disabled all of the other hardware in
> the system.

This may be a foolish question, but, are there possibly any code paths
in the *BIOS* that could care?

-Barry K. Nathan <barryn@pobox.com>

