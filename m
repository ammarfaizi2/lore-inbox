Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbTDSQa0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 12:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbTDSQaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 12:30:25 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:18560 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263411AbTDSQaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 12:30:25 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304191645.h3JGj331000483@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: rmk@arm.linux.org.uk (Russell King)
Date: Sat, 19 Apr 2003 17:45:03 +0100 (BST)
Cc: john@grabjohn.com (John Bradford),
       skraw@ithnet.com (Stephan von Krawczynski),
       linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20030419173602.E4082@flint.arm.linux.org.uk> from "Russell King" at Apr 19, 2003 05:36:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > A RAID-0 array and regular backups are the best way to protect your
> > data.
> 
> Correction.  RAID-0 is the best way to loose your data.  If any device
> containing any part of the array goes down, you loose at least some of
> your data.
> 
> RAID-1 is the redundant raid level, where each device in the set
> contains a duplicate of the other device(s).

Yes, sorry about that, I was being stupid again :-).

I meant a mirrored array.

John.
