Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264642AbTDZK13 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 06:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264644AbTDZK13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 06:27:29 -0400
Received: from mux1.uit.no ([129.242.4.252]:30995 "EHLO mux1.uit.no")
	by vger.kernel.org with ESMTP id S264642AbTDZK11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 06:27:27 -0400
Date: Sat, 26 Apr 2003 12:39:39 +0200
From: Tobias Brox <tobias@stud.cs.uit.no>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: nfsroot.c + ipconfig.c (2.4.20)
Message-ID: <20030426123939.D12540@stud.cs.uit.no>
Reply-To: tobias@stud.cs.uit.no
References: <200304231510.h3NFAh430564@lgserv3.stud.cs.uit.no> <shs8yu1uqak.fsf@charged.uio.no> <20030426123356.C12540@stud.cs.uit.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030426123356.C12540@stud.cs.uit.no>; from tobias@stud.cs.uit.no on Sat, Apr 26, 2003 at 12:33:56PM +0200
Organization: =?iso-8859-1?Q?University_of_Troms=F8?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Tobias Brox - Sat at 12:33:56PM +0200]
> I'd like to hear success-stories from people that
> have managed to do a diskless boot with a kernel of version 2.4.20 or
> more recent.

Oh .. for the record: after hacking a bit around, I did manage to boot
up disklessly with 2.4.20 - but when trying to mount other
NFS-partitions run-time, the mount-command hangs.  (This problem does
not occur when booting up with the same kernel on a computer with a
disk)

-- 
Check our new Mobster game at http://hstudd.cs.uit.no/mobster/
(web game, updates every 4th hour, no payment, no commercials)
