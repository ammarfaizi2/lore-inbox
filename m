Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbSK0RQH>; Wed, 27 Nov 2002 12:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbSK0RQH>; Wed, 27 Nov 2002 12:16:07 -0500
Received: from [81.2.122.30] ([81.2.122.30]:6916 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264624AbSK0RQG>;
	Wed, 27 Nov 2002 12:16:06 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200211271733.gARHXonq000193@darkstar.example.net>
Subject: Who maintains README?  (Was: modversions problem with 2.5.48 + .49)
To: kernelmarc@tirwhan.org (Marc)
Date: Wed, 27 Nov 2002 17:33:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DE4F929.9060005@tirwhan.org> from "Marc" at Nov 27, 2002 04:56:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>I cannot successfully make dep on either 2.5.48 or 2.5.49
> >You don't need to anymore.
> *boggle*...See, I knew I was being thick ;-). Thanks a lot John!
> Might I respectfully suggest the 'make dep' step be removed from the 
> kernel main README-file then?

Yes, it should be updated.  Also, the instructions for patching the
kernel are wrong, -p1 is now in use, not -p0.

Who actually maintains the README?

John.
