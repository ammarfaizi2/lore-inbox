Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132770AbRDIPsq>; Mon, 9 Apr 2001 11:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132774AbRDIPsh>; Mon, 9 Apr 2001 11:48:37 -0400
Received: from SMTP2.ANDREW.CMU.EDU ([128.2.10.82]:19349 "EHLO
	smtp2.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S132770AbRDIPsY>; Mon, 9 Apr 2001 11:48:24 -0400
Date: Mon, 9 Apr 2001 11:48:28 -0400
To: linux-kernel@vger.kernel.org
Subject: Processes hanging in D state in 2.4.3 - any findings?
Message-ID: <20010409114828.A25594@antenas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: "Eloy A. Paris" <eparis@andrew.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I have seen several messages posted to l-k about people reporting
processes (mozilla most of the time) hanging in the D state in 2.4.3,
but I haven't seen someone posting a possible explanation or solution 
to the problem.

Anyone knows where does the problem lie, or a workaround for the
problem? I hate going through the fsck that happens when umount fails
because processes are in the D state...

Cheers!

Eloy.-
