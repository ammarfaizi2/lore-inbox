Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbTDYGr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 02:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbTDYGr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 02:47:26 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2944 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263050AbTDYGrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 02:47:25 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304250702.h3P72FZF000352@81-2-122-30.bradfords.org.uk>
Subject: Re: Flame Linus to a crisp!
To: jamie@shareable.org (Jamie Lokier)
Date: Fri, 25 Apr 2003 08:02:15 +0100 (BST)
Cc: core@enodev.com (Shawn), john@grabjohn.com (John Bradford),
       miller@techsource.com (Timothy Miller),
       phillips@arcor.de (Daniel Phillips),
       wli@holomorphy.com (William Lee Irwin III),
       torvalds@transmeta.com (Linus Torvalds),
       linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20030425054759.GA32431@mail.jlokier.co.uk> from "Jamie Lokier" at Apr 25, 2003 06:47:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'd like to see an x86 completely in perf board. I thought my high
> > school digital electronics type stuff looked bad...
> 
> You could do it nowadays using dynamic binary translation, and an
> absurdly simple CPU capable of accessing a large memory.  You'd need a
> DIMM for the large memory, but get away with discrete logic for the
> CPU if you really wanted to.
> 
> At perf board sizes using discrete logic, expect it run run quite slow :)

Could we not take this idea to it's logical extreme, and simply
calculate the results of every opcode, on every value, for every state
of all of the registers, and store them in an array of DIMMs, and
simply look up the necessary results?  I.E. a cpu which is one _huge_
look up table :-).

John.
