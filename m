Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbTDQOMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbTDQOMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:12:03 -0400
Received: from uni03du.unity.ncsu.edu ([152.1.13.103]:51073 "EHLO
	uni03du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S261488AbTDQOMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:12:02 -0400
From: jlnance@unity.ncsu.edu
Date: Thu, 17 Apr 2003 10:23:56 -0400
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RedHat 9 and 2.5.x support
Message-ID: <20030417142356.GA7195@ncsu.edu>
References: <20030416165408.GD30098@wind.cocodriloo.com> <1050511742.15637.24.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050511742.15637.24.camel@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 12:49:02PM -0400, Robert Love wrote:
> On Wed, 2003-04-16 at 12:54, Antonio Vargas wrote:
> 
> > I've just installed RedHat 9 on my desktop machine and I'd like
> > if it will support running under 2.5.65+ instead of his usual
> > 2.4.19+.
> 
> Other than modutils(*) there are no issues with RH9 and 2.5.  I am
> running RH9 with 2.5 on my daily workstation.

I have a related question.  While I am confident I can get RH9 to work
with a 2.5 kernel, I would like to do this in such a way that booting
into a 2.4 kernel still works, and installing updated 2.4 kernel RPMs
from Red Hat also continues to work.  I would also like to avoid making
any changes that prevent me from upgrading to the next RH release.  I
assume I can accomplish this by only making changes that involve installing
rpms rather than installing programs directly.  I am not confident I can 
accomplish all this, having failed in my attempt with RH8 :-)

Can anyone comment on the feasibility of this?

Thanks,

Jim
