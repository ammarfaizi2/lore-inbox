Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbTCGOaj>; Fri, 7 Mar 2003 09:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261610AbTCGOaj>; Fri, 7 Mar 2003 09:30:39 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:14086 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261605AbTCGOah>; Fri, 7 Mar 2003 09:30:37 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303071442.h27EglLq001737@81-2-122-30.bradfords.org.uk>
Subject: Re: LKML
To: szepe@pinerecords.com (Tomas Szepe)
Date: Fri, 7 Mar 2003 14:42:46 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030307142606.GG14525@louise.pinerecords.com> from "Tomas Szepe" at Mar 07, 2003 03:26:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Mar  7 11:32:10 galileo kernel: Call Trace:    [<e28a45a7>] [<e28a457b>]
> > [<e28a483a>] [<e28abf1e>] [<c011a489>]
> > Mar  7 11:32:10 galileo kernel:   [<e28ad040>] [<e28ad07c>] [<e28ad07c>]
> > [<c0121b71>] [<c0121a50>] [<c0105000>]
> > Mar  7 11:32:10 galileo kernel:   [<c0105606>] [<c0121a50>]
> 
> Oh yeah, I had one of those, but the wheels fell off.

Didn't you compile it with

./configure --disable-wobbly-wheels
make
make install

???

John.
