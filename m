Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291273AbSAaU3V>; Thu, 31 Jan 2002 15:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291272AbSAaU3L>; Thu, 31 Jan 2002 15:29:11 -0500
Received: from zeke.inet.com ([199.171.211.198]:13974 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S291273AbSAaU3G>;
	Thu, 31 Jan 2002 15:29:06 -0500
Message-ID: <3C59A904.1ABC93BF@inet.com>
Date: Thu, 31 Jan 2002 14:28:52 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-10enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@atnf.csiro.au>
CC: linux-kernel@vger.kernel.org
Subject: vfs.txt and i_ino
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

It appears that struct inode i_ino has a special value of 0.  I don't
see a mention of that in vfs.txt, and I haven't found anything obvious
in the fs code... Would it be possible to add some documentation of
that, along with an explaination of what i_ino==0 is supposed to
indicate?  (Bad/invalid inode?)

TIA,

Eli 
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------
