Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267231AbTAPTgW>; Thu, 16 Jan 2003 14:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267227AbTAPTgW>; Thu, 16 Jan 2003 14:36:22 -0500
Received: from [81.2.122.30] ([81.2.122.30]:8198 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267231AbTAPTgV>;
	Thu, 16 Jan 2003 14:36:21 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301161944.h0GJic4p002523@darkstar.example.net>
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
To: mingo@elte.hu
Date: Thu, 16 Jan 2003 19:44:38 +0000 (GMT)
Cc: hch@infradead.org, rml@tech9.net, efocht@ess.nec.de, mbligh@aracnet.com,
       hohnbaum@us.ibm.com, habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.44.0301162025300.9563-100000@localhost.localdomain> from "Ingo Molnar" at Jan 16, 2003 08:44:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > well, it needs to settle down a bit more, we are technically in a
> > > codefreeze :-)
> > 
> > We're in feature freeze.  Not sure whether fixing the scheduler for one
> > type of hardware supported by Linux is a feature 8)

Yes, we are definitely _not_ in a code freeze yet, and I doubt that we
will be for at least a few months.

John.
