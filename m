Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbTDQOrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTDQOrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:47:45 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:8576 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261609AbTDQOro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:47:44 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304171502.h3HF221W000231@81-2-122-30.bradfords.org.uk>
Subject: Re: RedHat 9 and 2.5.x support
To: jjasen@realityfailure.org (John Jasen)
Date: Thu, 17 Apr 2003 16:02:02 +0100 (BST)
Cc: john@grabjohn.com (John Bradford), jlnance@unity.ncsu.edu,
       rml@tech9.net (Robert Love), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0304171054000.13853-100000@bushido> from "John Jasen" at Apr 17, 2003 10:54:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If you don't use modules at all, and simply compile everything in, you
> > can ignore the modutils issue completely.  Other than that, you should
> > have no problems.
> 
> Isn't modules-init backward compatible, or did I read wrong somewhere?

Yes, but I was assuming that you'd want to leave the RedHat module
utilities RPM as it was, to make future upgrades easier.

I.E. you can use 2.5.X without hitting the modutils issue at all, is
what I meant.

John.
