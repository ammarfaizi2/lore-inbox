Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267255AbTAAO4D>; Wed, 1 Jan 2003 09:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267256AbTAAO4D>; Wed, 1 Jan 2003 09:56:03 -0500
Received: from [81.2.122.30] ([81.2.122.30]:19207 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267255AbTAAO4C>;
	Wed, 1 Jan 2003 09:56:02 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301011504.h01F4Gxt001123@darkstar.example.net>
Subject: Re: a few more "make xconfig" inconsistencies
To: szepe@pinerecords.com (Tomas Szepe)
Date: Wed, 1 Jan 2003 15:04:16 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030101145120.GL14184@louise.pinerecords.com> from "Tomas Szepe" at Jan 01, 2003 03:51:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh, I see what you mean.  This behavior is a "feature" of the old
> xconfig (it's been so since the 2.0 times or thereabouts). menuconfig
> will hide entirely what xconfig merely grays out.

I actually like that feature :-(.

On the other hand, the TCL-based config system has gone completely in
2.5.  I look forward to the 2.7 tree opening when hopefully somebody
will bring it back as an extra choice, just for the sake of it :-).

John.
