Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290322AbSAXVbB>; Thu, 24 Jan 2002 16:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290323AbSAXVaw>; Thu, 24 Jan 2002 16:30:52 -0500
Received: from firewall.digsol.net ([63.228.1.219]:4335 "EHLO
	flanders.digsol.net") by vger.kernel.org with ESMTP
	id <S290322AbSAXVaq>; Thu, 24 Jan 2002 16:30:46 -0500
Date: Thu, 24 Jan 2002 15:30:40 -0600
From: "Marc A. Ohmann" <marc@ds6.net>
To: linux-kernel@vger.kernel.org
Subject: Re: AMD 2.4.17 hard freeze - Update
Message-ID: <20020124153040.A7028@flanders.digsol.net>
In-Reply-To: <20020123183932.A5077@flanders.digsol.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020123183932.A5077@flanders.digsol.net>; from marc@ds6.net on Wed, Jan 23, 2002 at 06:39:32PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.2.19 from slack bare.i also froze today (during a 2.4.17 compile).  I added the mem=nopentium a couple days ago and there was no difference.  Win2K worked successfully for the 3rd day in a row. :-(

after the freezes I almost always have to run e2fsck manually on the partition with the sources -- I assume thats because its such a hard freeze

-- 
------ Marc A. Ohmann  marc@ds6.net ------ Digital Solutions, Inc. ------
|                                    |   .~.                            | 
|  - Internet Hosting                |   /V\          L I N U X         | 
|  - Application Programming         |  // \\                           |
|  - Network Administration          | /(   )\    Solution Provider     |
|                                    |  ^^-^^                           |
-----------<a href="http://ds6.net">Digital Solutions, Inc</a>-----------
