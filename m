Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbTD1CPD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 22:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTD1CPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 22:15:03 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:12168 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262526AbTD1CPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 22:15:03 -0400
To: Mark Grosberg <mark@nolab.conman.org>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       =?iso-8859-1?q??= =?iso-8859-1?q? =?ISO-8859-1?Q?=20M=E5ns?=
	 =?ISO-8859-1?Q?=20Rullg=E5rd=3F=3D?= <mru@users.sourceforge.net>,
       Larry McVoy <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Combined fork-exec syscall.
References: <Pine.BSO.4.44.0304272154080.23296-100000@kwalitee.nolab.conman.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 28 Apr 2003 11:27:04 +0900
In-Reply-To: <Pine.BSO.4.44.0304272154080.23296-100000@kwalitee.nolab.conman.org>
Message-ID: <buoy91vuzk7.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Grosberg <mark@nolab.conman.org> writes:
> How do MMU-less archs spawn processes? Do they always use vfork()?

Yes

-Miles
-- 
Is it true that nothing can be known?  If so how do we know this?  -Woody Allen
