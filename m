Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTDYFf7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 01:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbTDYFf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 01:35:59 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:37256 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263025AbTDYFf6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 01:35:58 -0400
Date: Fri, 25 Apr 2003 06:47:59 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Shawn <core@enodev.com>
Cc: John Bradford <john@grabjohn.com>, Timothy Miller <miller@techsource.com>,
       Daniel Phillips <phillips@arcor.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
Message-ID: <20030425054759.GA32431@mail.jlokier.co.uk>
References: <200304242138.h3OLc824000522@81-2-122-30.bradfords.org.uk> <1051240827.17021.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051240827.17021.3.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn wrote:
> I'd like to see an x86 completely in perf board. I thought my high
> school digital electronics type stuff looked bad...

You could do it nowadays using dynamic binary translation, and an
absurdly simple CPU capable of accessing a large memory.  You'd need a
DIMM for the large memory, but get away with discrete logic for the
CPU if you really wanted to.

At perf board sizes using discrete logic, expect it run run quite slow :)

-- Jamie
