Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263186AbTDLHr5 (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 03:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTDLHrx (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 03:47:53 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:12672 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263186AbTDLHrs (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 03:47:48 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304120755.h3C7tUag000408@81-2-122-30.bradfords.org.uk>
Subject: Re: kernel support for non-English user messages
To: mbligh@aracnet.com (Martin J. Bligh)
Date: Sat, 12 Apr 2003 08:55:30 +0100 (BST)
Cc: 76306.1226@compuserve.com (Chuck Ebbert),
       linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <156450000.1050101626@flay> from "Martin J. Bligh" at Apr 11, 2003 03:53:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  Today it's all HTML documents or PDFs or something, but it's still
> > a staggering amount of information.  I have ~300MB of Oracle
> > documentation on one desktop, 6 of it server error messages alone.
> > Every possible message is explained to some extent, except this one:
> 
> IMHO, it'd be better to just make the kernel error messages meaningful.
> Keeping a large pile of documentation in sync with the source is
> a PITA.

You don't have to keep it in sync with the source - just make sure
that any documentation always mentions which versions it relates to.

If the documentation gets outdated, and everybody is aware of that, we
are no worse off than we are now.

John.
