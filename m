Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbUAMVNC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbUAMVMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:12:16 -0500
Received: from linux.us.dell.com ([143.166.224.162]:23733 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S265624AbUAMVKc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:10:32 -0500
Date: Tue, 13 Jan 2004 15:10:16 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Scott Long <scott_long@adaptec.com>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Proposed Enhancements to MD
Message-ID: <20040113151016.C7646@lists.us.dell.com>
References: <40036902.8080403@adaptec.com> <20040113081932.A721@lists.us.dell.com> <400436CC.7020007@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <400436CC.7020007@pobox.com>; from jgarzik@pobox.com on Tue, Jan 13, 2004 at 01:19:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 01:19:56PM -0500, Jeff Garzik wrote:
> Matt Domsch wrote:
> > I haven't seen the spec yet myself, but I'm lead to believe that
> > DDF allows for multiple logical drives to be created across a single
> > set of disks (e.g. a 10GB RAID1 LD and a 140GB RAID0 LD together on
> > two 80GB spindles), as well as whole disks be used.  It has a
> 
> 
> Me either.  Any idea if there will be a public comment period, or is the 
> spec "locked" into 1.0 when it's released in a month or so?

As it happens, Bill Dawkins of Dell is the DDF committee chair at
SNIA.  Here's what he's told me:

The current draft of the DDF specification is available for review
to any member of SNIA. This is a "Work in Progress" draft. Anyone in a
member company can go to www.snia.org and sign up for web access. They
will then have to sign up for the DDF Technical Working Group.
Acceptance to the DDF TWG is automatic and the current documents are
available there.
(As Dell is a member, I signed up for the DDF TWG as an observer.
Other companies are also on the member list, including Sistina, so
Jeff you may be able to get a Sistina collegue to mail you a copy.
http://www.snia.org/about/member_list has the list of member
companies. - Matt)

For people and companies who are not members of SNIA, I am writing to
the SNIA Technical Director to see if I can release copies of the
draft spec now. I'll let you know when I get a response.

As for the timeline, we have a face to face meeting of the DDF TWG
next Tuesday and it is our intent to vote on releasing the
specification as a "Trial Use" specification for public review and
comment. If the vote is affirmative, the SNIA Technical Council will
have to meet to determine when and if to release the "Trial Use"
specification. This may take a few months, so we are probably looking
at March for full release. Feel free to share this information with
your Linux contacts.



So, for now, if you're in SNIA, you can get access to the draft spec,
and in a few months the draft spec should be publicly available.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
