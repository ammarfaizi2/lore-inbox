Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316961AbSF0UwI>; Thu, 27 Jun 2002 16:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316968AbSF0UwH>; Thu, 27 Jun 2002 16:52:07 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:6640 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S316961AbSF0UwG>; Thu, 27 Jun 2002 16:52:06 -0400
Date: Thu, 27 Jun 2002 13:54:22 -0700
From: Chris Wright <chris@wirex.com>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: dax@gurulabs.com, Michael Kerrisk <m.kerrisk@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Status of capabilities?
Message-ID: <20020627135422.B26112@figure1.int.wirex.com>
Mail-Followup-To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
	dax@gurulabs.com, Michael Kerrisk <m.kerrisk@gmx.net>,
	linux-kernel@vger.kernel.org
References: <1025157926.1652.35.camel@mentor> <200206271257.HAA61267@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200206271257.HAA61267@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Thu, Jun 27, 2002 at 07:57:19AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jesse Pollard (pollard@tomcat.admin.navo.hpc.mil) wrote:
> 
> Actually, I think most of that work has already been done by the Linux
> Security Module project (well, except #7).

The LSM project supports capabilities exactly as it appears in the
kernel right now.  The EA linkage is still missing.  Of course, we are
accepting patches ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
