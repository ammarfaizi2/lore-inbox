Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbVA0AVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVA0AVZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVA0AVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:21:17 -0500
Received: from orb.pobox.com ([207.8.226.5]:3297 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262493AbVAZW6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 17:58:45 -0500
Date: Wed, 26 Jan 2005 14:58:33 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sytse Wielinga <s.b.wielinga@student.utwente.nl>,
       "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@lists.osdl.org, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 4/29] x86-i8259-shutdown
Message-ID: <20050126225833.GA8153@ip68-4-98-123.oc.oc.cox.net>
References: <20050125094350.GA6372@ip68-4-98-123.oc.oc.cox.net> <m1brbdhl3l.fsf@ebiederm.dsl.xmission.com> <20050125104904.GB5906@ip68-4-98-123.oc.oc.cox.net> <m13bwphflw.fsf@ebiederm.dsl.xmission.com> <20050125220229.GB5726@ip68-4-98-123.oc.oc.cox.net> <m1651lupjj.fsf@ebiederm.dsl.xmission.com> <20050126132741.GA23182@speedy.student.utwente.nl> <m1pszsffnp.fsf@ebiederm.dsl.xmission.com> <20050126144346.GD23182@speedy.student.utwente.nl> <m1llagfcmy.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1llagfcmy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 08:12:05AM -0700, Eric W. Biederman wrote:
> Do you know if there is any deliberate reason Alt-SysRq-O skips
> doing a normal device shutdown work?

I would guess that it's intended for use when things are so messed up
that all you want to do is cut power ASAP. But, that's just a guess.

-Barry K. Nathan <barryn@pobox.com>

