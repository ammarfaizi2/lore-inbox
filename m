Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269987AbTGXTJj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 15:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269994AbTGXTJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 15:09:39 -0400
Received: from 25.mdrx.com ([65.67.58.25]:41397 "EHLO duallie.mdrx.com")
	by vger.kernel.org with ESMTP id S269987AbTGXTJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 15:09:37 -0400
From: Brian Jackson <brian@brianandsara.net>
To: linux-kernel@vger.kernel.org
Subject: Re: time for some drivers to be removed?
Date: Thu, 24 Jul 2003 14:24:40 -0500
User-Agent: KMail/1.5.2
References: <200307241443.h6OEh3Qd000249@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200307241443.h6OEh3Qd000249@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307241424.40725.brian@brianandsara.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 July 2003 09:43 am, John Bradford wrote:
<snip>
>
> Some people might be interested in it.  Maybe somebody would like to
> fix it, but can't buy the physical hardware for any price.  Maybe
> everybody who has the hardware can't fix it because other kernel bugs
> prevent them from using the latest kernels on their machines.  Why
> remove it when it's doing no harm whatsoever?

I can think of one reason:
$ ls -lhGrS /usr/portage/distfiles/linux-2.*

-rw-r--r--    1      23M Apr 10  2002 
/usr/portage/distfiles/linux-2.4.18.tar.bz2
-rw-r--r--    1      25M Aug 19  2002 
/usr/portage/distfiles/linux-2.4.19.tar.bz2
-rw-r--r--    1      26M Feb 22 21:26 
/usr/portage/distfiles/linux-2.4.20.tar.bz2
-rw-r--r--    1      27M Jun 13 09:52 
/usr/portage/distfiles/linux-2.4.21.tar.bz2
-rw-r--r--    1      30M Feb 10 13:05 
/usr/portage/distfiles/linux-2.5.60.tar.bz2
-rw-r--r--    1      30M Feb 24 13:30 
/usr/portage/distfiles/linux-2.5.63.tar.bz2
-rw-r--r--    1      30M Mar  4 21:47 
/usr/portage/distfiles/linux-2.5.64.tar.bz2
-rw-r--r--    1      30M Mar 17 16:29 
/usr/portage/distfiles/linux-2.5.65.tar.bz2
-rw-r--r--    1      30M Apr 19 22:02 
/usr/portage/distfiles/linux-2.5.68.tar.bz2
-rw-r--r--    1      30M Mar 24 17:23 
/usr/portage/distfiles/linux-2.5.66.tar.bz2
-rw-r--r--    1      30M Apr 11 12:16 
/usr/portage/distfiles/linux-2.5.67.tar.bz2
-rw-r--r--    1      32M Jul 10 15:21 
/usr/portage/distfiles/linux-2.5.75.tar.bz2

2.6 doesn't seem to be swelling that fast, but 2.4 is

>
> John.

--Brian Jackson

-- 
OpenGFS -- http://opengfs.sourceforge.net
Home -- http://www.brianandsara.net

