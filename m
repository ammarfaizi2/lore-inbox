Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbTEBORC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 10:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTEBORC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 10:17:02 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:13786 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261915AbTEBORB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 10:17:01 -0400
Date: Fri, 2 May 2003 10:06:03 -0400
From: Ben Collins <bcollins@debian.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: The Spirit of Open Source <tsoos@scoloses.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Did the SCO Group plant UnixWare source in the Linux kernel?
Message-ID: <20030502140602.GH543@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Chris Sontag: We are using objective third parties to do comparisons of 
> our UNIX System V [SCO-owned Unix] source code and Red Hat as an example. 
> We are coming across many instances where our proprietary software has 
> simply been copied and pasted or changed in order to hide the origin of our 
> System V code in Red Hat. This is the kind of thing that we will need to 
> address with many Linux distribution companies at some point."

This almost sounds like they are pointing to userspace code rather than
kernel code. I know Redhat and other dists put patches on their kernels,
but I seriously doubt it's anything like retrofiting UnixWare code. It's
more like supporting newer hardware, performance tweaking, and such.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
