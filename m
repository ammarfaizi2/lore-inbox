Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261383AbREQJjz>; Thu, 17 May 2001 05:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbREQJjp>; Thu, 17 May 2001 05:39:45 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:14368 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S261383AbREQJjh>;
	Thu, 17 May 2001 05:39:37 -0400
Message-ID: <20010517113924.B9270@win.tue.nl>
Date: Thu, 17 May 2001 11:39:24 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Mauelshagen@sistina.com
Cc: thomasko321k@gmx.at (Thomas Kotzian), helgehaf@idb.hist.no (Helge Hafting),
        linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <20010516185845.A14397@sistina.com> <200105170635.f4H6Ztq456282@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200105170635.f4H6Ztq456282@saturn.cs.uml.edu>; from Albert D. Cahalan on Thu, May 17, 2001 at 02:35:55AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2001 at 02:35:55AM -0400, Albert D. Cahalan wrote:

> The PC partition table has such an ID. The LILO change log
> mentions it. I think it's 6 random bytes, with some restriction
> about being non-zero.

You are confused. The partition table contains IDs, but these are
the numbers like 83 for a Linux partition. No disk-identifying numbers.

