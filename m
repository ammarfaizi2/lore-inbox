Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280961AbRLOAdX>; Fri, 14 Dec 2001 19:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281024AbRLOAdN>; Fri, 14 Dec 2001 19:33:13 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:33786 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280961AbRLOAc4>; Fri, 14 Dec 2001 19:32:56 -0500
Date: Fri, 14 Dec 2001 16:31:10 -0800
From: Russ Weight <rweight@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
        LSE Tech <lse-tech@lists.sourceforge.net>
Subject: Static/Global Arrays
Message-ID: <20011214163110.A2423@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	
	I have tabulated lists of static and global arrays in the
2.4.16 kernel. I am posting the information here in case it may be
of interest to some of you. I would recommend starting with the 
linux/kernel and linux/fs tables, as these are the most complete.

	http://lse.sourceforge.net/resource/#staticarray

Background:
-----------
These tables were created as part of a larger effort to identify
static resource limits which could perhaps be made dynamic or
configurable. The notes column should eventually contain the
following information.

	(1) A _very_ brief description of the array
	(2) Any static limits associated with resource
	    allocation should be noted.

See the linux/kernel and linux/fs tables for examples of these notes.

Moving Forward:
---------------
Many of the arrays in these tables have not yet been annotated.
For me this has been very educational - lots of unfamiliar source
code to read. For many of you, it would be simply a matter of noting
things you already understand. If you find this information useful
and feel inclined to contribute, I would welcome contributions and/or
modifications to the notes in these tables.

- Russ
-- 
Russ Weight (rweight@us.ibm.com)
Linux Technology Center
