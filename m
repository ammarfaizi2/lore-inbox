Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbTDQOdp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbTDQOdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:33:45 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1408 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261545AbTDQOdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:33:44 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304171448.h3HEmDPX000121@81-2-122-30.bradfords.org.uk>
Subject: Re: RedHat 9 and 2.5.x support
To: jlnance@unity.ncsu.edu
Date: Thu, 17 Apr 2003 15:48:13 +0100 (BST)
Cc: rml@tech9.net (Robert Love), linux-kernel@vger.kernel.org
In-Reply-To: <20030417142356.GA7195@ncsu.edu> from "jlnance@unity.ncsu.edu" at Apr 17, 2003 10:23:56 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I've just installed RedHat 9 on my desktop machine and I'd like
> > > if it will support running under 2.5.65+ instead of his usual
> > > 2.4.19+.
> > 
> > Other than modutils(*) there are no issues with RH9 and 2.5.  I am
> > running RH9 with 2.5 on my daily workstation.
> 
> I have a related question.  While I am confident I can get RH9 to work
> with a 2.5 kernel, I would like to do this in such a way that booting
> into a 2.4 kernel still works, and installing updated 2.4 kernel RPMs
> from Red Hat also continues to work.  I would also like to avoid making
> any changes that prevent me from upgrading to the next RH release.  I
> assume I can accomplish this by only making changes that involve installing
> rpms rather than installing programs directly.  I am not confident I can 
> accomplish all this, having failed in my attempt with RH8 :-)
> 
> Can anyone comment on the feasibility of this?

If you don't use modules at all, and simply compile everything in, you
can ignore the modutils issue completely.  Other than that, you should
have no problems.

John.
