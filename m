Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268141AbTAKVOa>; Sat, 11 Jan 2003 16:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268143AbTAKVOa>; Sat, 11 Jan 2003 16:14:30 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:9747 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S268141AbTAKVO3>; Sat, 11 Jan 2003 16:14:29 -0500
Date: Sat, 11 Jan 2003 13:20:58 -0800 (PST)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Brian Jackson <brian@mdrx.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: More on Linux and iSCSI [info, not flame :)]
In-Reply-To: <20030111.sx2.96571900@duallie.mdrx.com>
Message-ID: <Pine.LNX.4.10.10301111217150.11839-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jan 2003, Brian Jackson wrote:

> Guys, There is another one that is at least decent and up to date, GPL'ed, etc. I'll
> be the first to admit it needs some work, but they dok have a target and an
> initiator. It's worth a look.
> 
> http://www.iol.unh.edu/consortiums/iscsi/
> 
> --Brian Jackson

Do remember you need CHAP and SRP authentications.
Do remember you need full ACL's
Do remember you need all corner cases.
Do remember you need Sync-n-Steering.
Do remember you need to support the entire spec.
Do remember all optionals are manditory.

I forgot the rest of the list, but this plus more are the min.
requirements.

Cheers,


Andre Hedrick, CTO & Founder 
iSCSI Software Solutions Provider
http://www.PyXTechnologies.com/


